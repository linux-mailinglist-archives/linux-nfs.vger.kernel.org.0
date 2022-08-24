Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6A59FFD8
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Aug 2022 18:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiHXQxb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Aug 2022 12:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbiHXQx2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Aug 2022 12:53:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29021CB01
        for <linux-nfs@vger.kernel.org>; Wed, 24 Aug 2022 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sxkFUC2OyinXrkZBMHkVDY66z00C/JNS9K+AqfzdpiE=; b=U224UccuJZOvbBsaAXuTnglTiX
        LLTOmtLy3PS7SvzK4ISivnJQBcMtFUJRahu+lDcRc1RlwP4mrgFOhA/2aFlVv8KtHxhD8w2sqXoYe
        ZzKZoa1mgnxDLe9DkIHdn1eCmx5jieBfcJK14ysTuLotrXo0wUJycaiea4TSKA/NYxkYG3KRcA1kz
        aBGzK+wLabZ3C+uJb9eo5xohcI0IfMaSHVBrIs51g+OlFFx9vq1l4cTeGoVYUninkAjOGxdOvt7XA
        1diudGYUPmd23t2LhI3Vgpo4ITjAZPt4vxQ7yVInomfvxCPCYZyPorDqwhbMdqZatUs2JM+oevG4B
        +z5tmxVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQtcz-00GVDg-Qv; Wed, 24 Aug 2022 16:53:17 +0000
Date:   Wed, 24 Aug 2022 17:53:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "daire.byrne@gmail.com" <daire.byrne@gmail.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "benmaynard@google.com" <benmaynard@google.com>
Subject: Re: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode
 and Kconfig
Message-ID: <YwZXfSXMzZgaSPAg@casper.infradead.org>
References: <da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com>
 <20220824093501.384755-1-dwysocha@redhat.com>
 <20220824093501.384755-3-dwysocha@redhat.com>
 <429ecc819fcffe63d60dbb2b72f9022d2a21ddd8.camel@hammerspace.com>
 <CALF+zOknvMZyufSUD-g9Z9Y5RfwE-vUFT+CF0kxqbcpR=yJPJw@mail.gmail.com>
 <216681.1661350326@warthog.procyon.org.uk>
 <5ab3188affa7e56e68a4f66a42f45d7086c1da23.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab3188affa7e56e68a4f66a42f45d7086c1da23.camel@hammerspace.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 24, 2022 at 04:27:04PM +0000, Trond Myklebust wrote:
> Right now, I see limited value in adding multipage folios to NFS.
> 
> While basic NFSv4 does allow you to pretend there is a fundamental
> underlying block size, pNFS has changed all that, and we have had to
> engineer support for determining the I/O block size on the fly, and
> building the RPC requests accordingly. Client side mirroring just adds
> to the fun.
> 
> As I see it, the only value that multipage folios might bring to NFS
> would be smaller page cache management overhead when dealing with large
> files.

Yes, but that's a Really Big Deal.  Machines with a lot of memory end
up with very long LRU lists.  We can't afford the overhead of managing
memory in 4kB chunks any more.  (I don't want to dwell on this point too
much; I've run the numbers before and can do so again if you want me to
go into more details).

Beyond that, filesystems have a lot of interactions with the page cache
today.  When I started looking at this, I thought filesystem people all
had a deep understanding of how the page cache worked.  Now I realise
everyone's as clueless as I am.  The real benefit I see to projects like
iomap/netfs is that they insulate filesystems from having to deal with
the page cache.  All the interactions are in two or three places and we
can refactor without having to talk to the owners of 50+ filesystems.

It also gives us a chance to re-examine some of the assumptions that
we have made over the years about how filesystems and page cache should
be interacting.  We've fixed a fair few bugs in recent years that came
about because filesystem people don't tend to have deep knowledge of mm
internals (and they shouldn't need to!)

I don't know that netfs has the perfect interface to be used for nfs.
But that too can be changed to make it work better for your needs.
