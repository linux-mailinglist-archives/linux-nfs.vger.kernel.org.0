Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118735A1578
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Aug 2022 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiHYPUX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Aug 2022 11:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbiHYPUW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Aug 2022 11:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23415F99F
        for <linux-nfs@vger.kernel.org>; Thu, 25 Aug 2022 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661440819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XQ0zizG3JIm8OS2VlQWWOaTpPfbwpR27OdcnkuAHDw8=;
        b=ZOkN/cb5SMvmYjzu2m5l015+HCpKw5GOsuszm5dTExAru20Gd17+Hn0wLLfZIQzYVWCv34
        eNYkNtftQYf7Jc3wOQR0J6uWanijekwggWo+5RotwvS2RHmiXEVZz8EIZ6jfP+p02HXHXT
        rc9f2NZOV84Ey3QgSPFebJAPRfan9Bc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-zhIdyrAXMgarkHt3jx9c0g-1; Thu, 25 Aug 2022 11:20:17 -0400
X-MC-Unique: zhIdyrAXMgarkHt3jx9c0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87EA23801140;
        Thu, 25 Aug 2022 15:20:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61873C15BBA;
        Thu, 25 Aug 2022 15:20:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5ab3188affa7e56e68a4f66a42f45d7086c1da23.camel@hammerspace.com>
References: <5ab3188affa7e56e68a4f66a42f45d7086c1da23.camel@hammerspace.com> <da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com> <20220824093501.384755-1-dwysocha@redhat.com> <20220824093501.384755-3-dwysocha@redhat.com> <429ecc819fcffe63d60dbb2b72f9022d2a21ddd8.camel@hammerspace.com> <CALF+zOknvMZyufSUD-g9Z9Y5RfwE-vUFT+CF0kxqbcpR=yJPJw@mail.gmail.com> <216681.1661350326@warthog.procyon.org.uk>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     dhowells@redhat.com,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "daire.byrne@gmail.com" <daire.byrne@gmail.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "benmaynard@google.com" <benmaynard@google.com>
Subject: Re: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode and Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3931440.1661440815.1@warthog.procyon.org.uk>
Date:   Thu, 25 Aug 2022 16:20:15 +0100
Message-ID: <3931441.1661440815@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond Myklebust <trondmy@hammerspace.com> wrote:

> While basic NFSv4 does allow you to pretend there is a fundamental
> underlying block size, pNFS has changed all that, and we have had to
> engineer support for determining the I/O block size on the fly, and
> building the RPC requests accordingly. Client side mirroring just adds
> to the fun.

I've been working with Jeff to make netfslib handle ceph with its distributed
object model as well as 9p and afs with their more traditionally-appearing
flat files.

> However let's start with the "why?" question first. Why do I need an
> extra layer of abstraction between NFS and the VM, when one of my
> primary concerns right now is that the stack depth keeps growing?

It's not exactly an extra layer - it's more a case of taking the same layer
out of five[*] network filesystems, combining them and sharing it.

[*] up to 7 if I can roll it out into orangefs and/or fuse as well.

As to why, well I kind of covered that, but we want to add some services to
network filesystems (such as content encryption) and rather than adding
separately to all five, there exists the possibility of just doing it the once
and sharing it (granted there may be parts that can't be shared).

But also, I need to fix cachefiles - and I can't do that whilst nfs is
operating on a page-by-page basis.  Cachefiles has to have an early say on the
size and shape of a transaction.

And speaking of content encryption, if you're using a local cache and content
encryption, you really don't want the unencrypted data to be stored in your
local cache on your laptop, say - so that requires storage of the encrypted
data into the cache.

Further, the VM folks would like the PG_private_2 bit back, along with
PG_checked and PG_error.  So we need a different way of managing writes to the
cache and preventing overlapping DIO writes.

> What problems would any of this solve for NFS? I'm worried about the
> cost of all this proposed code churn as well; as you said 'it is
> complicated stuff', mainly for the good reason that we've been
> optimising a lot of code over the last 25-30 years.

First off, NFS would get to partake of services being implemented in netfslib.
Granted, this isn't exactly solving problems in NFS, more providing additional
features.

Secondly, shared code means less code - and the code would, in theory, be
better-tested as it would have more users.

Thirdly, it would hopefully reduce the maintenance burden, particularly for
the VM people.

David

