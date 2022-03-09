Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09024D3C1C
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 22:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbiCIVdU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 16:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiCIVdT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 16:33:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DB4211D79A
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 13:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646861539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBOlenYCvFIb4MeX0O1Y4pISWifeC2EFuZ988voTLdk=;
        b=NVsPTlOYmJ3LNyQyKveQdb8zNdmwuHqMgkorymFhEzjLy71fck17BfR/gbBoIlkNh+mY/F
        QC0VchzAWQfXm7PYDQAqiwsuDQs4vQ+Hew0XvGWtNcXa6d8eKbG+1j0+xGHX0MJ5s8bpA4
        OHD8/HFq84eFisxqYxbZUrgA/kAX9B0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-Pk8d25hwNTGRxbk0FbcpNQ-1; Wed, 09 Mar 2022 16:32:16 -0500
X-MC-Unique: Pk8d25hwNTGRxbk0FbcpNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 291991800D50;
        Wed,  9 Mar 2022 21:32:15 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3CAF99CC;
        Wed,  9 Mar 2022 21:32:14 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v9 00/27] Readdir improvements
Date:   Wed, 09 Mar 2022 16:32:13 -0500
Message-ID: <23255C00-57BD-49D5-B228-F4D2C0AFDB32@redhat.com>
In-Reply-To: <20220227231227.9038-1-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 27 Feb 2022, at 18:12, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> The current NFS readdir code will always try to maximise the amount of
> readahead it performs on the assumption that we can cache anything that
> isn't immediately read by the process.
> There are several cases where this assumption breaks down, including
> when the 'ls -l' heuristic kicks in to try to force use of readdirplus
> as a batch replacement for lookup/getattr.
>
> This series also implement Ben's page cache filter to ensure that we can
> improve the ability to share cached data between processes that are
> reading the same directory at the same time, and to avoid live-locks
> when the directory is simultaneously changing.
>
> --
> v2: Remove reset of dtsize when NFS_INO_FORCE_READDIR is set
> v3: Avoid excessive window shrinking in uncached_readdir case
> v4: Track 'ls -l' cache hit/miss statistics
>     Improved algorithm for falling back to uncached readdir
>     Skip readdirplus when files are being written to
> v5: bugfixes
>     Skip readdirplus when the acdirmax/acregmax values are low
>     Request a full XDR buffer when doing READDIRPLUS
> v6: Add tracing
>     Don't have lookup request readdirplus when it won't help
> v7: Implement Ben's page cache filter
>     Reduce the use of uncached readdir
>     Change indexing of the page cache to improve seekdir() performance.
> v8: Reduce the page cache overhead by shrinking the cookie hashvalue size
>     Incorporate other feedback from Anna, Ben and Neil
>     Fix nfs2/3_decode_dirent return values
>     Fix the change attribute value set in nfs_readdir_page_get_next()
> v9: Address bugs that were hit when testing with large directories
>     Misc cleanups

Hi Trond, thanks for all this work!  I went through these from your testing
branch (612896ec5a4e) rather than the posting.

If it pleases, these can all get marked with my

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
and/or
Tested-by: Benjamin Coddington <bcodding@redhat.com>

.. except for 25/27, which is missing from the testing branch.

As I replied to 23/27, I don't understand how the page index hashing is
going to help out the re-export seekdir case, I think it might make it
worse, and I think its unnecessary extra complication.

I did test extensively total directory listing correctness, and it appears
to me that you are correct, we are not regressing.  We're in a similar place
as before.  I think we can be even more correct with directory verifiers or
post-op updates with GETATTR in the READDIR compound for very little cost,
but I've already made those arguments a few weeks ago.

Thanks again,
Ben

