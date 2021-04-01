Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AD7351750
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 19:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhDARlw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 13:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234089AbhDARgR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 13:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617298570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=saBotKFgw1hOFD1n1j2V3LDI7I47Bq8tKs5GFwPNPag=;
        b=aRzwKS2CkfpDO5eMWUeAcEsYdw1yDP29/k8YNW/0LDGNFdPCJ+NBnnTm5qna7Qgr60GQU5
        3f8lp2etgrwRSrhWP1THc4Z0RVFWO6mOMj0STvQkv+tZvryB1ui60rSd4H0u1TgsFUFh6Q
        gUiNiHWhkuln5QK+scqeFGPzjVfOd50=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-HWiyVbXkPg6KJnsDI5D_uw-1; Thu, 01 Apr 2021 11:35:10 -0400
X-MC-Unique: HWiyVbXkPg6KJnsDI5D_uw-1
Received: by mail-yb1-f197.google.com with SMTP id t5so6056562ybc.18
        for <linux-nfs@vger.kernel.org>; Thu, 01 Apr 2021 08:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saBotKFgw1hOFD1n1j2V3LDI7I47Bq8tKs5GFwPNPag=;
        b=Q5CVGahnjtC/nTmdx4KCQo/wbQvKDZCfmJTlpp5Of65NCEqC3ELEA6DDGPxcxQzfFK
         BnA3oLOQha2BLGi+Wp/FYXhykaTPzHwul/8emm7pMpT5han/oRaRqhMs0ipOLJ6wKMjP
         e3EGdaFiJ2SlvPTCLdeNy/20n7kQUqxCM4DiJiSNnILmd603C7CSnD6dbYV+CidtspRN
         fpzbb6RQW5VGiJNtINS4JxN2JTLgVG9PSKeXNyWOFTHQgJdvRodxBpelRgJYNFewnu61
         bAherAfTyUQXXTNI0lq7llCa01+6EGfFwfMKsTHOkjfzRI86XQ1dHQQ41/6GO7H0uG6n
         7qOw==
X-Gm-Message-State: AOAM530upjWErEQtdeDGvTq9JlWo4tVFu7OBVGRvLYNE2HYLMtlY99CJ
        IHRdAmynxJKrigrqADKfLr/HqpSeitsPR7lKFFHUMneioD0LiGjBS8/TugSfVhhYZc8s4NK5Lcg
        InJ+CPd91DZOdJMVDftkzJJgfEJTaq4wslQXa
X-Received: by 2002:a25:660a:: with SMTP id a10mr12221256ybc.102.1617291309439;
        Thu, 01 Apr 2021 08:35:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFd9Ann9970BsIHj5jDuRC4+mrZDNy6nvi+e3yCKEbEIwUOPhRXCeG8mH5Fjuc70jH/+6en1HxJo842Km9uK8=
X-Received: by 2002:a25:660a:: with SMTP id a10mr12221225ybc.102.1617291309191;
 Thu, 01 Apr 2021 08:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <49e123c6702cb6b27f114dfa64157d9a73463fad.camel@hammerspace.com>
 <CALF+zOnCisFWTubWEHhTLpt6=CUb7n86YvrNX3nreCYS73_v_Q@mail.gmail.com>
 <3727198.1617285066@warthog.procyon.org.uk> <20210401151339.GE351017@casper.infradead.org>
In-Reply-To: <20210401151339.GE351017@casper.infradead.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 1 Apr 2021 11:34:33 -0400
Message-ID: <CALF+zOkqN8XfOKf6coDzuiVMhqZrbZVK7-XTKT7zx42+BG6LdA@mail.gmail.com>
Subject: Re: RFC: Approaches to resolve netfs API interface to NFS multiple
 completions problem
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 1, 2021 at 11:13 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Apr 01, 2021 at 02:51:06PM +0100, David Howells wrote:
> >  (1) The way cachefiles reads data from the cache is very hacky (calling
> >      readpage on the backing filesystem and then installing an interceptor on
> >      the waitqueue for the PG_locked page flag on that page, then memcpying
> >      the page in a worker thread) - but it was the only way to do it at the
> >      time.  Unfortunately, it's fragile and it seems just occasionally the
> >      wake event is missed.
> >
> >      Since then, kiocb has come along.  I really want to switch to using this
> >      to read/write the cache.  It's a lot more robust and also allows async
> >      DIO to be performed, also cutting out the memcpy.
> >
> >      Changing the fscache IO part of API would make this easier.
>
> I agree with this.  The current way that fscache works is grotesque.
> It knows far too much about the inner workings of, well, everything.
>
> >  (3) VM changes are coming that affect the filesystem address space
> >      operations.  THP is already here, though not rolled out into all
> >      filesystems yet.  Folios are (probably) on their way.  These manage with
> >      page aggregation.  There's a new readahead interface function too.
> >
> >      This means, however, that you might get an aggregate page that is
> >      partially cached.  In addition, the current fscache IO API cannot deal
> >      with these.  I think only 9p, afs, ceph, cifs, nfs plus orangefs don't
> >      support THPs yet.  The first five Willy has held off on because fscache
> >      is a complication and there's an opportunity to make a single solution
> >      that fits all five.
>
> This isn't quite uptodate:
>
>  - The new readahead interface went into Linux in June 2020.
>    All filesystems were converted from readpages to readahead except
>    for the five above that use fscache.  It would be nice to remove the
>    readpages operation, but I'm trying not to get in anyone's way here,
>    and the fscache->netfs transition was already underway.
>  - THPs in Linux today are available to precisely one filesystem --
>    shmem/tmpfs.  There are problems all over the place with using THPs
>    for non-in-memory filesystems.
>  - My THP work achieved POC status.  I got some of the prerequistite
>    bits in, but have now stopped working on it (see next point).  It works
>    pretty darned well on XFS only.  I did do some work towards enabling
>    it on NFS, but never tested it.  There's a per-filesystem enable bit,
>    so in theory NFS never needs to be converted.  In practice, you're
>    going to want to for the performance boost.
>  - I'm taking the lessons learned as part of the THP work (it's confusing
>    when a struct page may refer to part of a large memory allocation or
>    all of a large memory allocation) and introducing a new data type
>    (the struct folio) to refer to chunks of memory in the page cache.
>    All filesystems are going to have to be converted to the new API,
>    so the fewer places that filesystems actually deal with struct page,
>    the easier this makes the transition.
>  - I don't understand how a folio gets to be partially cached.  Cached
>    should be tracked on a per-folio basis (like dirty or uptodate), not
>    on a per-page basis.  The point of the folio work is that managing
>    memory in page-sized chunks is now too small for good performance.
>
> > So with the above, there is an opportunity to abstract handling of the VM I/O
> > ops for network filesystems - 9p, afs, ceph, cifs and nfs - into a common
> > library that handles VM I/O ops and translates them to RPC calls, cache reads
> > and cache writes.  The thought is that we should be able to push the
> > aggregation of pages into RPC calls there, handle rsize/wsize and allow
> > requests to be sliced up and so that they can be distributed to multiple
> > servers (works for ceph) so that all five filesystems can get the same
> > benefits in one go.
>
> If NFS wants to do its own handling of rsize/wsize, could it?  That is,
> if the VM passes it a 2MB page and says "read it", and the server has
> an rsize of 256kB, could NFS split it up and send its own stream of 8
> requests, or does it have to use fscache to do that?
>

Yes NFS will split up say the 2MB VM read into smaller requests (RPCs)
as needed, based on rsize and other factors such as the pNFS layouts.
It does not need fscache or netfs APIs to do this - it's always handled it.

The issue I'm trying to resolve is how to best plug the current netfs API
into NFS. Previously, the fscache API was page based, so when an RPC
would complete with fscache enabled, we'd call an fscache API on a single
page.  The current netfs API specifies a 'subrequest' which is a set of pages.
Originally I thought this would not be a problem because there are NFS
internal APIs which essentially handle a series of pages into one request
(this is the pagelist.c and nfs_page.h functions I referred to).  But digging
deeper it seems it is a bit more challenging since the splitting of the requests
by NFS happen deeper than I realized, and so it does not look doable
for example to tell netfs how large a single NFS request may be (this was
why the "clamp_length()" function was added to netfs API).

