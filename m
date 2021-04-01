Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637453519EA
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 20:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhDAR45 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 13:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234651AbhDARwT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 13:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67Er4MV/wJhUyvFI71H33Z16SnubDGfMvDZkluV+Vw0=;
        b=hdDgzIM6mVKiZPvoUko4I9gfGwap8QbV2KI5ujAceS5Gp6s0PpDCZLy4RwmnBy1MZOnRfB
        Es6ONQ1V7jQ+ADVgPvhM2s4U5m1hkBtmcN+3J+eD0zZrhGnOKqrlrLYKOmewBUGSmqOUo8
        Jo5WipaHYk+eIOfavE3Ne2fvo+ooOY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-v7_FZzn1OqWifiNC8_qtQg-1; Thu, 01 Apr 2021 09:51:10 -0400
X-MC-Unique: v7_FZzn1OqWifiNC8_qtQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74D46108BD06;
        Thu,  1 Apr 2021 13:51:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D814614FC;
        Thu,  1 Apr 2021 13:51:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <49e123c6702cb6b27f114dfa64157d9a73463fad.camel@hammerspace.com>
References: <49e123c6702cb6b27f114dfa64157d9a73463fad.camel@hammerspace.com> <CALF+zOnCisFWTubWEHhTLpt6=CUb7n86YvrNX3nreCYS73_v_Q@mail.gmail.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     dhowells@redhat.com, "dwysocha@redhat.com" <dwysocha@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        Matthew Wilcox <willy@infradead.org>, jlayton@kernel.org,
        Steve French <sfrench@samba.org>
Subject: Re: RFC: Approaches to resolve netfs API interface to NFS multiple completions problem
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3727197.1617285066.1@warthog.procyon.org.uk>
Date:   Thu, 01 Apr 2021 14:51:06 +0100
Message-ID: <3727198.1617285066@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond Myklebust <trondmy@hammerspace.com> wrote:

> > I've been working on getting NFS converted to dhowells new fscache
> > and
> > netfs APIs and running into a problem with how NFS is designed and it
> > involves the NFS pagelist.c / pgio API.  I'd appreciate it if you
> > could review and give your thoughts on possible approaches.  I've
> > tried to outline some of the possibilities below.  I tried coding
> > option #3 and ran into some problems, and it has a serialization
> > limitation.  At this point I'm leaning towards option 2, so I'll
> > probably try that approach if you don't have time for review or have
> > strong thoughts on it.
>
> I am not going through another redesign of the NFS code in order to
> accommodate another cachefs design. If netfs needs a refactoring or
> redesign of the I/O code then it will be immediately NACKed.
>
> Why does netfs need to know these details about the NFS code anyway?

There are some issues we have to deal with in fscache - and some
opportunities.

 (1) The way cachefiles reads data from the cache is very hacky (calling
     readpage on the backing filesystem and then installing an interceptor on
     the waitqueue for the PG_locked page flag on that page, then memcpying
     the page in a worker thread) - but it was the only way to do it at the
     time.  Unfortunately, it's fragile and it seems just occasionally the
     wake event is missed.

     Since then, kiocb has come along.  I really want to switch to using this
     to read/write the cache.  It's a lot more robust and also allows async
     DIO to be performed, also cutting out the memcpy.

     Changing the fscache IO part of API would make this easier.

 (2) The way cachefiles finds out whether data is present (using bmap) is not
     viable on ext4 or xfs and has to be changed.  This means I have to keep
     track of the presence of data myself, separately from the backing
     filesystem's own metadata.

     To reduce the amount of metadata I need to keep track of and store, I
     want to increase the cache granularity - that is I will only store, say,
     blocks of 256K.  But that needs to feed back up to the filesystem so that
     it can ask the VM to expand the readahead.

 (3) VM changes are coming that affect the filesystem address space
     operations.  THP is already here, though not rolled out into all
     filesystems yet.  Folios are (probably) on their way.  These manage with
     page aggregation.  There's a new readahead interface function too.

     This means, however, that you might get an aggregate page that is
     partially cached.  In addition, the current fscache IO API cannot deal
     with these.  I think only 9p, afs, ceph, cifs, nfs plus orangefs don't
     support THPs yet.  The first five Willy has held off on because fscache
     is a complication and there's an opportunity to make a single solution
     that fits all five.

     Also to this end, I'm trying to make it so that fscache doesn't retain
     any pointers back into the network filesystem structures, beyond the info
     provided to perform a cache op - and that is only required on a transient
     basis.

 (4) I'd like to be able to encrypt the data stored in the local cache and
     Jeff Layton is adding support for fscrypt to ceph.  It would be nice if
     we could share the solution with all of the aforementioned bunch of five
     filesystems by putting it into the common library.

So with the above, there is an opportunity to abstract handling of the VM I/O
ops for network filesystems - 9p, afs, ceph, cifs and nfs - into a common
library that handles VM I/O ops and translates them to RPC calls, cache reads
and cache writes.  The thought is that we should be able to push the
aggregation of pages into RPC calls there, handle rsize/wsize and allow
requests to be sliced up and so that they can be distributed to multiple
servers (works for ceph) so that all five filesystems can get the same
benefits in one go.

Btw, I'm also looking at changing the way indexing works, though that should
only very minorly alter the nfs code and doesn't require any restructuring.
I've simplified things a lot and I'm hoping to remove a couple of thousand
lines from fscache and cachefiles.

David

