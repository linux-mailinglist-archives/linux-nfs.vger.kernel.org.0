Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6739B69B008
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Feb 2023 16:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBQP7e (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Feb 2023 10:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBQP7e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Feb 2023 10:59:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766516E648
        for <linux-nfs@vger.kernel.org>; Fri, 17 Feb 2023 07:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZzpghLQGzUYKbLwSkhJz9Ki/jZAlqAynY4knQMGIw7Q=; b=R+MGrkd+mWvcRx6B0DgDPjOgrG
        +/1sKd81mSoDl+C+nPuLUw6LFsX129xhKpBjIpm+kfr1j2qS+rRuWry3uMhmtCyt5tTiL2pR6+Fu/
        iDMDyYm07H80rDoKrvNE0mveYX5F4i77p7gJn3uEzah0r2jOSuysVy9Eg8Pk2/nOEwgszGWvYcPs6
        ZLA/Q5ZlHlTRzS1UDUQrl5gG5ENHyEFYSjanCMjvwGKv/qMGIMOqp3ceapEdYRPkGxsxfiQz2kOXT
        PcK18fdHJf5gLwR8eoySjMIwbuMjuHnbPp3SROz7On6yKAuXsCgLLuGS94KRzoYIw6BPTnxAz/8vK
        9VtEx5/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pT38j-009R98-1R; Fri, 17 Feb 2023 15:59:13 +0000
Date:   Fri, 17 Feb 2023 15:59:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Daire Byrne <daire@dneg.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: /proc/PID/io/read_bytes accounting regression?
Message-ID: <Y++kUMY93plkyP6f@casper.infradead.org>
References: <CAPt2mGNEYUk5u8V4abe=5MM5msZqmvzCVrtCP4Qw1n=gCHCnww@mail.gmail.com>
 <CALF+zO=e+d3sdLA4MZ_-SZh3epWBKF=hY=8FB+aB8+H4rxe4KA@mail.gmail.com>
 <Y++RA7YXtymaQJ05@casper.infradead.org>
 <CALF+zOnVJ5+Pb_mq1KcD_jdVsP8Dkg9KPGGiRS8KDJzK7+mT6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALF+zOnVJ5+Pb_mq1KcD_jdVsP8Dkg9KPGGiRS8KDJzK7+mT6Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 17, 2023 at 10:47:01AM -0500, David Wysochanski wrote:
> On Fri, Feb 17, 2023 at 9:36 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Feb 17, 2023 at 09:08:27AM -0500, David Wysochanski wrote:
> > > On Fri, Feb 17, 2023 at 6:56 AM Daire Byrne <daire@dneg.com> wrote:
> > > > On newer kernels, it looks like the task io accounting is not
> > > > incrementing the read_bytes when reading from a NFS mount? This was
> > > > definitely working on v5.16 downwards, but has not been working since
> > > > v5.18 up to v6.2 (I haven't tested v5.17 yet).
> > >
> > > In v5.16 we had this call to task_io_account_read(PAGE_SIZE); on line 109
> > > of read_cache_pages();
> > >
> > > But there's no call to task_io_account_read() anymore in the new
> > > readahead code paths that I could tell,
> > > but maybe I'm missing something.
> > >
> > > Willy,
> > > Does each caller of readahead_page() now need to call
> > > task_io_account_read() or should we add that into
> > > readahead_page() or maybe inside read_pages()?
> >
> > I think the best way is to mimic what the block layer does as closely as
> > possible.  Unless we can pull it out of the block layer & all
> > filesystems and put it in the VFS (which we can't; the VFS doesn't
> > know which blocks are recorded by the filesystem as holes and will not
> > result in I/O).
> >
> Caller, ok.  I see, that makes sense.
> Looks like cifs has a call to task_io_account_read() after data has been
> received.  Also netfs has a call as well at the bottom of
> netfs_rreq_unlock_folios().
> Both seems to be _after_ data has been received, but I'm not sure that's
> correct.

It's probably correct, just different from the block layer.  I don't
have any special insight here, just an inclination to be as similar
as possible.

> > The block layer does it as part of the BIO submission path (and also
> > counts PGPGIN and PGPGOUT, which no network filesystems seem to do?)
> > You're more familiar with the NFS code than I am, so you probably
> > have a better idea than __nfs_pageio_add_request().
> >
> Hmm, yes does the block layer's accounting take into account actual
> bytes read or just submitted?  Maybe I need to look at this closer
> but at first glance it looks like these numbers may sometimes be
> incremented when actual data is received and others are incremented
> when the submission happens.
> 
> As to the right location in NFS, the function you mention isn't a bad
> idea, but maybe not the right location.  Looking in nfs_file_direct_read()
> we have the accounting at IO submission time, appears to be the
> same as the block layer.  Also since my NFS netfs conversion patches
> are still outstanding, I'll have to somehow take the netfs call into account
> if fscache is enabled.  So the right place is looking like somewhere
> in nfs_read_folio() and nfs_readahead().

Yes, we don't want to double-count either fscache or direct I/O.
I'm Maybe Dave as opinions about where we should be accounting it --
I'm not sure that netfs is the right place to do it.  Maybe it should
be in each network filesystem instead of in netfs?
