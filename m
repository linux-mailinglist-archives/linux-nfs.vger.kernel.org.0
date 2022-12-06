Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C27864447A
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Dec 2022 14:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiLFNWf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Dec 2022 08:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiLFNWe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Dec 2022 08:22:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4655FD120
        for <linux-nfs@vger.kernel.org>; Tue,  6 Dec 2022 05:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670332896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9zY2/ptng73F64GgnuIHyLrbZldcFmxMWaInNFT/+8=;
        b=MBEyuKllbn0DINB5gIBeMf54psaTW1AMnnOVQnS/kMVLZZXwbB3+jocLVnkegCtllxxaKW
        asXG4eCOMjbGjxUfO56ph65WmKEr/9Fu2h2vyBHgMQHdtrvWcokpFvbuztAZE4IyWvpYO/
        uqXW0BeAAgR42lNaBdrsTK4RS084L0k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-z1xuBA92N0-Zdcfu8CAChQ-1; Tue, 06 Dec 2022 08:21:33 -0500
X-MC-Unique: z1xuBA92N0-Zdcfu8CAChQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2A5486EB20;
        Tue,  6 Dec 2022 13:21:32 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5651B40C6EC3;
        Tue,  6 Dec 2022 13:21:32 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Theodor Mittermair <tmittermair@cvl.tuwien.ac.at>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: NFS performance problem (readdir, getattr, actimeo, lookupcache)
Date:   Tue, 06 Dec 2022 08:21:27 -0500
Message-ID: <0193C32D-D74A-423C-AF08-58EB436FABDD@redhat.com>
In-Reply-To: <dc3b95d2-93d0-992f-8f02-75c5bbb3bdff@cvl.tuwien.ac.at>
References: <dc3b95d2-93d0-992f-8f02-75c5bbb3bdff@cvl.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5 Dec 2022, at 21:18, Theodor Mittermair wrote:

> Hello,

Hi Theodor,

.. snip ..

> From what i gathered around the internet and understood, there seem to be
> heuristics involved when the client decides what operations to transmit to
> the server.  Also, the timed-out cache seems to be creating what some
> called a "getattr storm", which i understand in theory.

When `du` gathers information, it does so by switching between two syscalls:
getdents() and stat() (or some equivalents).  The getdents() syscall causes
the NFS client to perform either READDIR or READDIRPLUS - the choice of
which is governed by a heuristic.  The heuristic can only intelligently
determine which readdir operation to use based on whether the program is
performing this pattern of getdents(), stat(), stat(), stat(), getdents(),
stat(), stat(), stat().  The way it can tell is by checking if each inode's
attributes have been cached, so the cache timeouts end up coming into play.

> But why does the first request manage to be smarter about it, since it
> gathers the same information about the exact same files?

It's not smarter, it just optimistically uses READDIRPLUS on the very first
call of getdents() for a directory, but can only do so if the directory's
dentries have not yet been cached.  If they /are/ cached, but each dentry's
individual attributes have timed out, then the client must send an
individual GETATTR for each entry.

What is happening for you is that your attribute caches for each inode are
timing out, but the overall directory's dentry list is not changing.
There's no need to send /any/ readdir operations - so the heuristic doesn't
send READDIRPLUS and you end up with one full pile of getdents() results of
individual GETATTRs for every entry.

If your server is returning a large dtpref (the preferred data transfer size
for readdir), and there's some latency for round-trip operations, you'll see
this stack up quickly in exactly the results you've presented.

There's a patch that may go into v6.2 to help this:
https://lore.kernel.org/linux-nfs/20220920170021.1391560-1-bcodding@redhat.com/

.. if you have the ability to test it in your setup, I'd be interested in
the results.

This heuristic's behavior is becoming harder to change, because over time we
have a lot of setups depending on certain performance characteristics and
changes in this area create unexpected performance regressions.

> I would be happy if i could maintain the initial-non-cached time (in the
> examples above 1.5 seconds) but none of
> "noac","lookupcache=none","actimeo=0" would let me achieve that seemingly.
>
> Is there a way to improve that situation, and if so, how?

Hopefully, the above patch will help.  We've all had wild ideas: maybe we
should also only do uncached readdir if lookupcache=none?  Its a bit
surprising that you'd opt to forego all caching just to optmize this `du`
case.  I don't think that's what you want, as it will negatively impact
other workloads.

I also think that if you were to dump all the directories' page caches
in between your calls to `du` you'd get consistent performance as in your
first pass.. something with POSIX_FADV_DONTNEED to fadvise(), but I'd be
leery of depending on this behavior, since its only a hint.

I also wonder if glibc() might be willing to check a hint (like an
environment variable?) about how big a buffer to send to getdents(), since I
suspect it might also be nice for some fuse filesystems.

Ben

