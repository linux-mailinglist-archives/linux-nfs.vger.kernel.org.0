Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E345A1501
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Aug 2022 17:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiHYPBj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Aug 2022 11:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiHYPBi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Aug 2022 11:01:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E5832EE
        for <linux-nfs@vger.kernel.org>; Thu, 25 Aug 2022 08:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Fnbblj7HoROnY68D1O/lKRAPjKH6WwYWuntkpAG+JR8=; b=KnZC620IeAaUo5v5+cPAfgGSv/
        nhrrxxhU2Ya28lFwZ+GPkdcYd1f8MAbCk/w8QQDvn/ASU0mtzKS6Y/YEG3r69ge+lDzjaiqLEeWTy
        CvzAnB4GNhWEeqTgNoE7q9yK/vM6gg7USogrrzP6zDGA7EIrM6sKM11n0QKI503IdyM0/MDmFXOUG
        f2VnNmyp2mGlqZnZe7qt4zwDHmHtEsqnU0EKnb5x45hLr++alKKuFqD11uK8+Wujl13Eu/vpV7sn3
        MDrx7r30jVA3yGiBGV+U9ulBifGDim42AB8a544lMwq6tuL53B1/eVCistdBcLTvNuEU6raMc7wGD
        acmMdOmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oREML-00HKgV-7u; Thu, 25 Aug 2022 15:01:29 +0000
Date:   Thu, 25 Aug 2022 16:01:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire.byrne@gmail.com" <daire.byrne@gmail.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "benmaynard@google.com" <benmaynard@google.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwysocha@redhat.com" <dwysocha@redhat.com>
Subject: Re: [RFC PATCH 2/3] NFS: Add support for netfs in struct nfs_inode
 and Kconfig
Message-ID: <YweOySTkKQ3PDLCv@casper.infradead.org>
References: <da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com>
 <20220824093501.384755-1-dwysocha@redhat.com>
 <20220824093501.384755-3-dwysocha@redhat.com>
 <429ecc819fcffe63d60dbb2b72f9022d2a21ddd8.camel@hammerspace.com>
 <CALF+zOknvMZyufSUD-g9Z9Y5RfwE-vUFT+CF0kxqbcpR=yJPJw@mail.gmail.com>
 <216681.1661350326@warthog.procyon.org.uk>
 <5ab3188affa7e56e68a4f66a42f45d7086c1da23.camel@hammerspace.com>
 <YwZXfSXMzZgaSPAg@casper.infradead.org>
 <5dfadceb26da1b4d8d499221a5ff1d3c80ad59c0.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dfadceb26da1b4d8d499221a5ff1d3c80ad59c0.camel@hammerspace.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 24, 2022 at 05:43:36PM +0000, Trond Myklebust wrote:
> On Wed, 2022-08-24 at 17:53 +0100, Matthew Wilcox wrote:
> > On Wed, Aug 24, 2022 at 04:27:04PM +0000, Trond Myklebust wrote:
> > > Right now, I see limited value in adding multipage folios to NFS.
> > > 
> > > While basic NFSv4 does allow you to pretend there is a fundamental
> > > underlying block size, pNFS has changed all that, and we have had
> > > to
> > > engineer support for determining the I/O block size on the fly, and
> > > building the RPC requests accordingly. Client side mirroring just
> > > adds
> > > to the fun.
> > > 
> > > As I see it, the only value that multipage folios might bring to
> > > NFS
> > > would be smaller page cache management overhead when dealing with
> > > large
> > > files.
> > 
> > Yes, but that's a Really Big Deal.  Machines with a lot of memory end
> > up with very long LRU lists.  We can't afford the overhead of
> > managing
> > memory in 4kB chunks any more.  (I don't want to dwell on this point
> > too
> > much; I've run the numbers before and can do so again if you want me
> > to
> > go into more details).
> > 
> > Beyond that, filesystems have a lot of interactions with the page
> > cache
> > today.  When I started looking at this, I thought filesystem people
> > all
> > had a deep understanding of how the page cache worked.  Now I realise
> > everyone's as clueless as I am.  The real benefit I see to projects
> > like
> > iomap/netfs is that they insulate filesystems from having to deal
> > with
> > the page cache.  All the interactions are in two or three places and
> > we
> > can refactor without having to talk to the owners of 50+ filesystems.
> > 
> > It also gives us a chance to re-examine some of the assumptions that
> > we have made over the years about how filesystems and page cache
> > should
> > be interacting.  We've fixed a fair few bugs in recent years that
> > came
> > about because filesystem people don't tend to have deep knowledge of
> > mm
> > internals (and they shouldn't need to!)
> > 
> > I don't know that netfs has the perfect interface to be used for nfs.
> > But that too can be changed to make it work better for your needs.
> 
> If the VM folks need it, then adding support for multi-page folios is a
> much smaller scope than what David was describing. It can be done
> without too much surgery to the existing NFS I/O stack. We already have
> code to support I/O block sizes that are much less than the page size,
> so converting that to act on larger folios is not a huge deal.
> 
> What would be useful there is something like a range tree to allow us
> to move beyond the PG_uptodate bit, and help make the
> is_partially_uptodate() address_space_operation a bit more useful.
> Otherwise, we end up having to read in the entire folio, which is what
> we do today for pages, but could get onerous with large folios when
> doing file random access.

This is interesting because nobody's asked for this before.  I've had
similar discussions around dirty data tracking, but not around uptodate.
Random small reads shouldn't be a terrible problem; if they truly are
random, we behave as today, allocating single pages, reading the entire
page from the server and setting it uptodate.  If the readahead code
detects a contiguous large read, we increase the allocation size to
match, but again we always read the entire folio from the server and
mark it uptodate.

As far as I know, the only time we create !uptodate folios in the page
cache is partial writes to a folio which has not been previously read.
Obviously, those bytes start out dirty and are tracked through the
existing dirty mechanism, but once they've been written back, we have
three choices that I can see:

1. transition those bytes to a mechanism which records they're uptodate
2. discard that information and re-read the entire folio from the server
   if any bytes are subsequently read
3. read the other bytes in that folio from the server and mark the
   entire folio uptodate

We have a mixture of those options implemented in different filesystems
today.  iomap records whether a block is uptodate or not and treats
every uptodate block as dirty if any block in the folio is dirty.
buffer_head has two bits for each block, separately recording whether
it's dirty and/or uptodate.  AFS tracks one dirty range per folio, but
it first brings the folio uptodate by reading it from the server before
overwriting it (I suppose that's a fourth option).

I don't see a compelling reason for different filesystems to behave
differently here.  I'd like us to settle on one design we can all share,
and I was hoping netfs would be the platform for that.
