Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370B0350670
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 20:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhCaSft (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 14:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43605 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235111AbhCaSfj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 14:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617215738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jsEpiofig3keIoGL7kBc/i3kTYjSrdwGCpFwlwx/PQQ=;
        b=YmVzubutGEDG9qwDh6CZyUVrfGys6yMOGYJV6S99fQ2tXAwHj8Hf0UFJlI4XoZT54yyOLt
        50P9Q6O/OzhYLHdHJc0rD2e8aXKed1Y9EfLzi/KaCPUhNrSKpTl+1Kk1a0BKFz96kuUUMT
        MmU7+bzo6hbEISAN0Mr/ISYfVtLjR2U=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-WGyTeElFP5aGIpPZZl3FKw-1; Wed, 31 Mar 2021 14:35:36 -0400
X-MC-Unique: WGyTeElFP5aGIpPZZl3FKw-1
Received: by mail-yb1-f199.google.com with SMTP id f75so3199964yba.8
        for <linux-nfs@vger.kernel.org>; Wed, 31 Mar 2021 11:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsEpiofig3keIoGL7kBc/i3kTYjSrdwGCpFwlwx/PQQ=;
        b=hfT38V+MwwP8pYRxo0vpfFAagbr8xr2F8G7tiYezBuBRSdqXGO5zY84I4I7sBdmJWP
         DeQGGO+myZam2rRcxvkgJXAUs5sCA0VN/grhpedF72sTsrBjOQ5rT9QMCOXT/dLsJjvg
         oFIf0P98npnMYq7ZOk6WpTWjoGGIvGRyIACQyGq3hum99cmu1A4ZYkaxclZcZ9rrd85q
         tP4VbrjB8yBf3r6V8AQ4RmEuoWxe+E8iq1bdQBokKi2j743stORAQSuORcF6WMfPa0ps
         sQTF0YYIzq5QHhwctK5RaXTlArm0H2qrRoEnFMHTOe+1czGYHc0OurotAVu8QJe8FhKK
         rpzw==
X-Gm-Message-State: AOAM530X6Hf3fMKWtpe19Tq2lI6C6p+SXkW+D/VDYcstU0yNn2cUKtjh
        bAvk8oL9R5tq7V3+hGBD+AKM9ZJPxqcqIZrTvaSx0F1FrjzQ3AU/Pd2HnsxbBb2h3H5W0jxcTen
        U+4pLzSlUZfFA3FHt+JoIaZecLOQewB/Qjr9r
X-Received: by 2002:a25:d40f:: with SMTP id m15mr6086676ybf.30.1617215736000;
        Wed, 31 Mar 2021 11:35:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVMMveZym/l12RLNQe/ze4TqFxz00E/qqZr/Us1iW/X7Qr7u9VWDy93aGdpXJbv+WdihC5guSpvb/BkuLimCY=
X-Received: by 2002:a25:d40f:: with SMTP id m15mr6086655ybf.30.1617215735719;
 Wed, 31 Mar 2021 11:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <CALF+zOnCisFWTubWEHhTLpt6=CUb7n86YvrNX3nreCYS73_v_Q@mail.gmail.com>
 <49e123c6702cb6b27f114dfa64157d9a73463fad.camel@hammerspace.com>
In-Reply-To: <49e123c6702cb6b27f114dfa64157d9a73463fad.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 31 Mar 2021 14:34:59 -0400
Message-ID: <CALF+zO=KeU7O-sACUgX556_Mxdb1Xrvq5foJT1Py2DROBojxfQ@mail.gmail.com>
Subject: Re: RFC: Approaches to resolve netfs API interface to NFS multiple
 completions problem
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 31, 2021 at 2:04 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2021-03-31 at 13:49 -0400, David Wysochanski wrote:
> > Trond,
> >
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
> >
>
> I am not going through another redesign of the NFS code in order to
> accommodate another cachefs design. If netfs needs a refactoring or
> redesign of the I/O code then it will be immediately NACKed.
>
I don't think it will require a redesign.  I was thinking more about
adding a flag to nfs_pageio_add_request() for example that
would return a different value if coalesce of the page being
added failed.  So we'd have:
nfs_pageio_init(): called 1 time
nfs_pageio_add_request(): called N times, one for each page, but stop if
coalesce fails
nfs_pageio_complete(): called 1 time

> Why does netfs need to know these details about the NFS code anyway?
>
We can probably get by without it but it will be awkward and probably not the
best, but I'm not sure.

I tried to explain below with a problem statement but maybe it was unclear.
The basic design of netfs API as it pertains to this problem is:
* issue_op(): calls into the specific netfs (NFS) to obtain the data from server
(send one or more RPCs)
* netfs_subreq_terminated(): when RPC(s) are completed, we need to call
netfs API back to say the data is either there or there was an error

I would note that assuming we can come up with something acceptable to
NFS, it should simplify both nfs_readpage() and nfs_readpages/nfs_readhead.
I hope we can find some common ground so it's neither too invasive to
NFS and also maybe there's some similar improvements in NFS that can
be done along with this interface.


> > Thanks.
> >
> >
> > Problem: The NFS pageio interface does not expose a max read length
> > that
> > we can easily use inside netfs clamp_length() function.  As a result,
> > when
> > issue_op() is called indicating a single netfs subrequest, this can
> > be
> > split into
> > multiple NFS subrequests / RPCs inside guts of NFS pageio code.
> > Multiple
> > NFS subrequests requests leads to multiple completions, and the netfs
> > API expects a 1:1 mapping between issue_op() and
> > netfs_subreq_terminated() calls.
> >
> > Details of the NFS pageio API (see include/linux/nfs_page.h and
> > fs/nfs/pagelist.c)
> > Details of the netfs API (see include/linux/netfs.h and
> > fs/netfs/read_helper.c)
> >
> > The NFS pageio API 3 main calls are as follows:
> > 1. nfs_pageio_init(): initialize a pageio structure (R/W IO of N
> > pages)
> > 2. nfs_pageio_add_request(): called for each page to add to an IO
> > * Calls nfs_pageio_add_request_mirror -> __nfs_pageio_add_request
> >   * __nfs_pageio_add_request may call nfs_pageio_doio() which
> > actually
> >     sends an RPC over the wire if page cannot be added to the request
> >     ("coalesced") due to various factors.  For more details, see
> >     nfs_pageio_do_add_request() and all underlying code it calls such
> >     as nfs_coalesce_size() and subsequent pgio->pg_ops->pg_test()
> > calls
> > 3. nfs_pageio_complete() - "complete" the pageio
> > * calls nfs_pageio_complete_mirror -> nfs_pageio_doio()
> >
> > The NFS pageio API thus may generate multiple over the wire RPCs
> > and thus multiple completions even though at the high level only
> > one call to nfs_pageio_complete() is made.
> >
> > Option 1: Just use NFS pageio API as is, and deal with possible
> > multiple
> > completions.
> > - Inconsistent with netfs design intent
> > - Need to keep track of the RPC completion status, and for example,
> > if one completes with success and one an error, probably call
> > netfs_subreq_terminated() with the error.
> > - There's no way for the caller of the NFS pageio API to know how
> > many RPCs and thus completions may occur.  Thus, it's unclear how
> > one would distinguish between a READ that resulted in a single RPC
> > over the wire that completed as a short read, and a READ that
> > resulted in multiple RPCs that would each complete separately,
> > but would eventually complete
> >
> > Option 2: Create a more complex 'clamp_length()' function for NFS,
> > taking into account all ways NFS / pNFS code can split a read.
> > + Consistent with netfs design intent
> > + Multiple "split" requests would be called in parallel (see loop
> > inside netfs_readahead, which repeatedly calls
> > netfs_rreq_submit_slice)
> > - Looks impossible without refactoring of NFS pgio API.  We need
> > to prevent nfs_pageio_add_request() from calling nfs_pagio_doio(),
> > and return some indication coalesce failed.  In addition, it may
> > run into problems with fallback from DS to MDS for example (see
> > commit d9156f9f364897e93bdd98b4ad22138de18f7c24).
> >
> > Option 3: Utilize NETFS_SREQ_SHORT_READ flag as needed.
> > + Consistent with netfs design intent
> > - Multiple "split" requests would be serialized (see code
> > paths inside netfs_subreq_terminated that check for this flag).
> > - Looks impossible without some refactoring of NFS pgio API.
> > * Notes: Terminate NFS pageio page based loop at the first call
> > to nfs_pageio_doio().  When a READ completes, NFS calls
> > netfs_subreq_terminated() with NETFS_SREQ_SHORT_READ
> > and is prepared to have the rest of the subrequest be resubmitted.
> > Need to somehow fail early or avoid entirely subsequent calls to
> > nfs_pagio_doio() for the original request though, and handle
> > error status only from the first RPC.
> >
> > Option 4: Add some final completion routine to be called near
> > bottom of nfs_pageio_complete() and would pass in at least
> > netfs_read_subrequest(), possibly nfs_pageio_descriptor.
> > + Inconsistent with netfs design intent
> > - Would be a new NFS API or call on top of everything
> > - Need to handle the "multiple completion with different
> > status" problem (see #1).
> >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

