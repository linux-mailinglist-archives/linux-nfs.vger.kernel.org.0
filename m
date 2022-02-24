Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7EE4C33CD
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 18:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiBXRce (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 12:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiBXRcd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 12:32:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2FEA1B7180
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 09:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645723922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AZY6DSzY0Ic3apL9uhfBn5AmDld3KbOgbwMiHcsy3jU=;
        b=Hu9vEKas0uyutQeTttnnb6pdKctAPBlt4Cqt172cuksAcIdaP5iwdr1rDqOyxGp4xNxNL+
        oy4cscZmbGzahPBufvJA4pgG0893hDHzFG76UXVjuTRUXE5YjItzeP+7Kn+LTPrB/Z0RaX
        2byTkwKGF7C3WJzbKRdXBXydJt3Ek5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-WfbBF5MePkad71PsfwGYLQ-1; Thu, 24 Feb 2022 12:31:58 -0500
X-MC-Unique: WfbBF5MePkad71PsfwGYLQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD1BD2E68;
        Thu, 24 Feb 2022 17:31:57 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64FD61057FDB;
        Thu, 24 Feb 2022 17:31:57 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 19/21] NFS: Convert readdir page cache to use a cookie
 based index
Date:   Thu, 24 Feb 2022 12:31:56 -0500
Message-ID: <EF67F180-F1D8-4291-92C8-86E5D10D1F25@redhat.com>
In-Reply-To: <20220223211305.296816-20-trondmy@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain
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

On 23 Feb 2022, at 16:13, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Instead of using a linear index to address the pages, use the cookie of
> the first entry, since that is what we use to match the page anyway.
>
> This allows us to avoid re-reading the entire cache on a seekdir() type
> of operation. The latter is very common when re-exporting NFS, and is a
> major performance drain.
>
> The change does affect our duplicate cookie detection, since we can no
> longer rely on the page index as a linear offset for detecting whether
> we looped backwards. However since we no longer do a linear search
> through all the pages on each call to nfs_readdir(), this is less of a
> concern than it was previously.
> The other downside is that invalidate_mapping_pages() no longer can use
> the page index to avoid clearing pages that have been read. A subsequent
> patch will restore the functionality this provides to the 'ls -l'
> heuristic.

This is cool, but one reason I did not explore this was that the page cache
index uses XArray, which is optimized for densly clustered indexes.  This
particular sentence in the documentation was enough to scare me away:

"The XArray implementation is efficient when the indices used are densely
clustered; hashing the object and using the hash as the index will not
perform well."

However, the "not perform well" may be orders of magnitude smaller than
anthing like RPC.  Do you have concerns about this?

Another option might be to flag the context after a seekdir, which would
trigger a shift in the page_index or "turn on" hashed indexes, however
that's really only going to improve the re-export case with v4 or cached
fds.

Or maybe the /first/ seekdir on a context sets its own offset into the
pagecache - that could be a hash, and pages are filled from there.

Hmm..

Ben

