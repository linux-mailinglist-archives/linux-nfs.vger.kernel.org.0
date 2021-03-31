Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D629F350724
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 21:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhCaTJN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:09:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234311AbhCaTIz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 15:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617217734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t5Q2P2nlKRZxni8QkKl4sxoIlDhD/32MoLxs12LITDQ=;
        b=b7x3q2MiUtgIxV1Cb/WWmWdh802v083a4IVeWY4tM4BaCupL0bXKIJ7p9RlhR5bJxKOXHT
        s/QKVYSdJbwGCkUptNXrMo4G+LZc0zqehCl1v9siQGawHTYtg2Km+sDwQ5LDYgg/tVRPa1
        9TLuCI11VsXNTa6n5wjxkMhv+pgrcmk=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-EDnJIN2tN-KnOYgJFVsjIw-1; Wed, 31 Mar 2021 15:08:50 -0400
X-MC-Unique: EDnJIN2tN-KnOYgJFVsjIw-1
Received: by mail-yb1-f200.google.com with SMTP id y13so3265916ybk.20
        for <linux-nfs@vger.kernel.org>; Wed, 31 Mar 2021 12:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5Q2P2nlKRZxni8QkKl4sxoIlDhD/32MoLxs12LITDQ=;
        b=afKgV15PgesprMs49VjzeQL4Ynb/NzczPTJf9gxewz4mUdovRbFJaYf9kvc5t+GrCL
         KRfjumahSGIe8Y7FjYf4+DCCS9gC18TLqx+0ZDHPBKjCd+HNJdBCn06y5Yn9soi5pMOY
         kkALdEhYXVbap5r5Vk/pooE15OgoL/o+6QG/kcJqnrU80tSEtClz/JoPZGzfy3TTfjuN
         Dzx/rtUzrHuMH+LV2KiZQJkfRhKa43//y8a4+BCuqugho/Utcpbz6fAfBaPZNR1Zefdj
         V5NRlibuPWA6zXrrPbGtYPsCRTDoxW3sSCyTNS7nWqOe1xcYbnyy/2gXUkEFoHNPAH/Z
         BTQg==
X-Gm-Message-State: AOAM532OBXTK+uEAfxII21iNvXCbs5h5mk9NrklBd0aZd1lr5JwZHD6p
        u3zysiLTvs1mBxIiEnqyxVohAGXNpTG3wJXPss2TMnK1VwYU8EL/wqgzI054TISDQmDiz5WtGi8
        0S2DPJd7t8uTdNnpSS2Mbk79T0AiR7Z8RucGO
X-Received: by 2002:a25:d40f:: with SMTP id m15mr6256644ybf.30.1617217729657;
        Wed, 31 Mar 2021 12:08:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+m/8zZ10bL67Hfg3ZlxhXZvcyVEEgZCEeOcaBlWLtTMIDncIYdVNUx9i1E1wYnAOwtSDBQGreTOGhorq9x6s=
X-Received: by 2002:a25:d40f:: with SMTP id m15mr6256615ybf.30.1617217729389;
 Wed, 31 Mar 2021 12:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <CALF+zOnCisFWTubWEHhTLpt6=CUb7n86YvrNX3nreCYS73_v_Q@mail.gmail.com>
 <49e123c6702cb6b27f114dfa64157d9a73463fad.camel@hammerspace.com>
 <CALF+zO=KeU7O-sACUgX556_Mxdb1Xrvq5foJT1Py2DROBojxfQ@mail.gmail.com> <9cfd5bc3cfc6abc2d3316b0387222e708d67f595.camel@hammerspace.com>
In-Reply-To: <9cfd5bc3cfc6abc2d3316b0387222e708d67f595.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 31 Mar 2021 15:08:13 -0400
Message-ID: <CALF+zO=XcB=+sMSG1BXhUSQDxNX5oi2p8zH5PWWBbe7aYB0yMw@mail.gmail.com>
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

On Wed, Mar 31, 2021 at 2:51 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2021-03-31 at 14:34 -0400, David Wysochanski wrote:
> > On Wed, Mar 31, 2021 at 2:04 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > >
> > > On Wed, 2021-03-31 at 13:49 -0400, David Wysochanski wrote:
> > > > Trond,
> > > >
> > > > I've been working on getting NFS converted to dhowells new
> > > > fscache
> > > > and
> > > > netfs APIs and running into a problem with how NFS is designed
> > > > and it
> > > > involves the NFS pagelist.c / pgio API.  I'd appreciate it if you
> > > > could review and give your thoughts on possible approaches.  I've
> > > > tried to outline some of the possibilities below.  I tried coding
> > > > option #3 and ran into some problems, and it has a serialization
> > > > limitation.  At this point I'm leaning towards option 2, so I'll
> > > > probably try that approach if you don't have time for review or
> > > > have
> > > > strong thoughts on it.
> > > >
> > >
> > > I am not going through another redesign of the NFS code in order to
> > > accommodate another cachefs design. If netfs needs a refactoring or
> > > redesign of the I/O code then it will be immediately NACKed.
> > >
> > I don't think it will require a redesign.  I was thinking more about
> > adding a flag to nfs_pageio_add_request() for example that
> > would return a different value if coalesce of the page being
> > added failed.  So we'd have:
> > nfs_pageio_init(): called 1 time
> > nfs_pageio_add_request(): called N times, one for each page, but stop
> > if
> > coalesce fails
> > nfs_pageio_complete(): called 1 time
> >
> > > Why does netfs need to know these details about the NFS code
> > > anyway?
> > >
> > We can probably get by without it but it will be awkward and probably
> > not the
> > best, but I'm not sure.
> >
> > I tried to explain below with a problem statement but maybe it was
> > unclear.
> > The basic design of netfs API as it pertains to this problem is:
> > * issue_op(): calls into the specific netfs (NFS) to obtain the data
> > from server
> > (send one or more RPCs)
> > * netfs_subreq_terminated(): when RPC(s) are completed, we need to
> > call
> > netfs API back to say the data is either there or there was an error
> >
>
> That's a problem. That means NFS and netfs need intimate knowledge of
> each other's design, and I'm not going allow us to go there again. We
> did that with cachefs, and here we are 10 years later doing a full
> redesign. That's unacceptable.
>

I don't think it's a full redesign, and my goal all along has been minimally
invasive to existing NFS.

I forgot to mention this part of netfs:
* clamp_length(): netfs calls into NFS here and we can clamp the length
to a specific size (for example 'rsize' for reads); this is what I'm trying to
see if I can implement fully or not but looks more complicated due to
coalescing failing, etc.  If not then there's other possible approaches
(NETFS_SREQ_SHORT_READ) but not sure they are ideal.


> If netfs requires these detailed changes to the NFS code, then that's a
> red flag that the whole design is broken and needs to be revised.
>
> > I would note that assuming we can come up with something acceptable
> > to
> > NFS, it should simplify both nfs_readpage() and
> > nfs_readpages/nfs_readhead.
> > I hope we can find some common ground so it's neither too invasive to
> > NFS and also maybe there's some similar improvements in NFS that can
> > be done along with this interface.
> >
> >
> > > > Thanks.
> > > >
> > > >
> > > > Problem: The NFS pageio interface does not expose a max read
> > > > length
> > > > that
> > > > we can easily use inside netfs clamp_length() function.  As a
> > > > result,
> > > > when
> > > > issue_op() is called indicating a single netfs subrequest, this
> > > > can
> > > > be
> > > > split into
> > > > multiple NFS subrequests / RPCs inside guts of NFS pageio code.
> > > > Multiple
> > > > NFS subrequests requests leads to multiple completions, and the
> > > > netfs
> > > > API expects a 1:1 mapping between issue_op() and
> > > > netfs_subreq_terminated() calls.
> > > >
> > > > Details of the NFS pageio API (see include/linux/nfs_page.h and
> > > > fs/nfs/pagelist.c)
> > > > Details of the netfs API (see include/linux/netfs.h and
> > > > fs/netfs/read_helper.c)
> > > >
> > > > The NFS pageio API 3 main calls are as follows:
> > > > 1. nfs_pageio_init(): initialize a pageio structure (R/W IO of N
> > > > pages)
> > > > 2. nfs_pageio_add_request(): called for each page to add to an IO
> > > > * Calls nfs_pageio_add_request_mirror -> __nfs_pageio_add_request
> > > >   * __nfs_pageio_add_request may call nfs_pageio_doio() which
> > > > actually
> > > >     sends an RPC over the wire if page cannot be added to the
> > > > request
> > > >     ("coalesced") due to various factors.  For more details, see
> > > >     nfs_pageio_do_add_request() and all underlying code it calls
> > > > such
> > > >     as nfs_coalesce_size() and subsequent pgio->pg_ops->pg_test()
> > > > calls
> > > > 3. nfs_pageio_complete() - "complete" the pageio
> > > > * calls nfs_pageio_complete_mirror -> nfs_pageio_doio()
> > > >
> > > > The NFS pageio API thus may generate multiple over the wire RPCs
> > > > and thus multiple completions even though at the high level only
> > > > one call to nfs_pageio_complete() is made.
> > > >
> > > > Option 1: Just use NFS pageio API as is, and deal with possible
> > > > multiple
> > > > completions.
> > > > - Inconsistent with netfs design intent
> > > > - Need to keep track of the RPC completion status, and for
> > > > example,
> > > > if one completes with success and one an error, probably call
> > > > netfs_subreq_terminated() with the error.
> > > > - There's no way for the caller of the NFS pageio API to know how
> > > > many RPCs and thus completions may occur.  Thus, it's unclear how
> > > > one would distinguish between a READ that resulted in a single
> > > > RPC
> > > > over the wire that completed as a short read, and a READ that
> > > > resulted in multiple RPCs that would each complete separately,
> > > > but would eventually complete
> > > >
> > > > Option 2: Create a more complex 'clamp_length()' function for
> > > > NFS,
> > > > taking into account all ways NFS / pNFS code can split a read.
> > > > + Consistent with netfs design intent
> > > > + Multiple "split" requests would be called in parallel (see loop
> > > > inside netfs_readahead, which repeatedly calls
> > > > netfs_rreq_submit_slice)
> > > > - Looks impossible without refactoring of NFS pgio API.  We need
> > > > to prevent nfs_pageio_add_request() from calling
> > > > nfs_pagio_doio(),
> > > > and return some indication coalesce failed.  In addition, it may
> > > > run into problems with fallback from DS to MDS for example (see
> > > > commit d9156f9f364897e93bdd98b4ad22138de18f7c24).
> > > >
> > > > Option 3: Utilize NETFS_SREQ_SHORT_READ flag as needed.
> > > > + Consistent with netfs design intent
> > > > - Multiple "split" requests would be serialized (see code
> > > > paths inside netfs_subreq_terminated that check for this flag).
> > > > - Looks impossible without some refactoring of NFS pgio API.
> > > > * Notes: Terminate NFS pageio page based loop at the first call
> > > > to nfs_pageio_doio().  When a READ completes, NFS calls
> > > > netfs_subreq_terminated() with NETFS_SREQ_SHORT_READ
> > > > and is prepared to have the rest of the subrequest be
> > > > resubmitted.
> > > > Need to somehow fail early or avoid entirely subsequent calls to
> > > > nfs_pagio_doio() for the original request though, and handle
> > > > error status only from the first RPC.
> > > >
> > > > Option 4: Add some final completion routine to be called near
> > > > bottom of nfs_pageio_complete() and would pass in at least
> > > > netfs_read_subrequest(), possibly nfs_pageio_descriptor.
> > > > + Inconsistent with netfs design intent
> > > > - Would be a new NFS API or call on top of everything
> > > > - Need to handle the "multiple completion with different
> > > > status" problem (see #1).
> > > >
> > >
> > > --
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trond.myklebust@hammerspace.com
> > >
> > >
> >
>
> --
> Trond Myklebust
> CTO, Hammerspace Inc
> 4984 El Camino Real, Suite 208
> Los Altos, CA 94022
>
> www.hammer.space
>

