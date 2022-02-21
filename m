Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8308D4BEBC0
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Feb 2022 21:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiBUUXF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Feb 2022 15:23:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiBUUXE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Feb 2022 15:23:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A32AB1144
        for <linux-nfs@vger.kernel.org>; Mon, 21 Feb 2022 12:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645474959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BKEDvfPmu7KhzBWvIC8YOjPSHfZoMEgD9jFMvmtmYQE=;
        b=hK4v1udg5Z/rJehs3V85qlu98WYeDI2TA9n11wHWatFLWUQyB8l39R4SxJShXigtcBPBD6
        Qshkts79KfA6FX6gLXztbPEDR+G/UMFI4v+ZnJVoy8+EsuusiBXq/EWkQqkwmrYoce1+zK
        UQIDXC5DJluY2MHlMEMi3n72eEJ7H+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-rY7bJariNt-clQ7_I6seCQ-1; Mon, 21 Feb 2022 15:22:36 -0500
X-MC-Unique: rY7bJariNt-clQ7_I6seCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 787A18030D2;
        Mon, 21 Feb 2022 20:22:35 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38562452F1;
        Mon, 21 Feb 2022 20:22:35 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Date:   Mon, 21 Feb 2022 15:22:34 -0500
Message-ID: <5B222AF7-98A7-428B-81B2-1A1D3FFAD944@redhat.com>
In-Reply-To: <e01f0373409aaf09dbaf59f3aa7deb421af68980.camel@hammerspace.com>
References: <20220221160851.15508-1-trondmy@kernel.org>
 <20220221160851.15508-2-trondmy@kernel.org>
 <20220221160851.15508-3-trondmy@kernel.org>
 <20220221160851.15508-4-trondmy@kernel.org>
 <20220221160851.15508-5-trondmy@kernel.org>
 <20220221160851.15508-6-trondmy@kernel.org>
 <BCE9A6AB-EAA5-477E-BFE7-529AEC443E6A@redhat.com>
 <e01f0373409aaf09dbaf59f3aa7deb421af68980.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 Feb 2022, at 14:58, Trond Myklebust wrote:

> On Mon, 2022-02-21 at 11:45 -0500, Benjamin Coddington wrote:
>> On 21 Feb 2022, at 11:08, trondmy@kernel.org wrote:
>>
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> When reading a very large directory, we want to try to keep the
>>> page
>>> cache up to date if doing so is inexpensive. Right now, we will try
>>> to
>>> refill the page cache if it is non-empty, irrespective of whether
>>> or not
>>> doing so is going to take a long time.
>>>
>>> Replace that algorithm with something that looks at how many times
>>> we've
>>> refilled the page cache without seeing a cache hit.
>>
>> Hi Trond, I've been following your work here - thanks for it.
>>
>> I'm wondering if there might be a regression on this patch for the
>> case
>> where two or more directory readers are part way through a large
>> directory
>> when the pagecache is truncated.  If I'm reading this correctly,
>> those
>> readers will stop caching after 5 fills and finish the remainder of
>> their
>> directory reads in the uncached mode.
>>
>> Isn't there an OP amplification per reader in this case?
>>
>
> Depends... In the old case, we basically stopped doing uncached readdir
> if a third process starts filling the page cache again. In particular,
> this means we were vulnerable to restarting over and over once page
> reclaim starts to kick in for very large directories.
>
> In this new one, we have each process give it a try (5 fills each), and
> then fallback to uncached. Yes, there will be corner cases where this
> will perform less well than the old algorithm, but it should also be
> more deterministic.
>
> I am open to suggestions for better ways to determine when to cut over
> to uncached readdir. This is one way, that I think is better than what
> we have, however I'm sure it can be improved upon.

I still have old patches that allow each page to be "versioned" with the
change attribute, page_index, and cookie.  This allows the page cache to be
culled page-by-page, and multiple fillers can continue to fill pages at
"headless" page offsets that match their original cookie and page_index
pair.  This change would mean readers don't have to start over filling the
page cache when the cache is dropped, so we wouldn't need to worry about
when to cut over to the uncached mode - it makes the problem go away.

I felt there wasn't much interest in this work, and our most vocal customer
was happy enough with last winter's readdir improvements (thanks!) that I
didn't follow up, but I can refresh those patches and send them along again.

Ben

