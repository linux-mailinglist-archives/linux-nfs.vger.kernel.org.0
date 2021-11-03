Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D0B443DE4
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Nov 2021 08:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhKCIAK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Nov 2021 04:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231425AbhKCIAH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Nov 2021 04:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635926248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V04PRVMq0Z/UDJz0xLKl1Xoe9Fq20tPJIRoMB0DtmQM=;
        b=BFqnOTDGAX8wZQWWojNFjrmDMz04R5dMGxGrzleARMpvDPbyLRkx4shl35U7OS5lDa8cvz
        smmgh81ZTnMD2eMLCkNWLe5PRCXv5dE46hvJdRp/7S/+zmm9fGLlV9zRytb0Z57C581pQO
        ticBAtQ1xDNPl2VZ+ILCFopsSxR22hU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-FGIDih-WM2y9ojLCSxI2DA-1; Wed, 03 Nov 2021 03:57:25 -0400
X-MC-Unique: FGIDih-WM2y9ojLCSxI2DA-1
Received: by mail-ed1-f71.google.com with SMTP id g3-20020a056402424300b003e2981e1edbso1727997edb.3
        for <linux-nfs@vger.kernel.org>; Wed, 03 Nov 2021 00:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V04PRVMq0Z/UDJz0xLKl1Xoe9Fq20tPJIRoMB0DtmQM=;
        b=dL1U5x0tvq1w04hh4kpwyzoOS2bdopengyt92lR6duoGUWlq3nB1IGQ1tdAky3NSU4
         D6s76MK/J2TUf+P00TJoV7bhsqwFyYWV3h48fhj7o3EDTTOYMuzSFhdZkVrUHO7763Rh
         Nk4a9mHFt54dLI2M8ATUJqgeO3oY+EpWz8Z1kK2KKA76V/M9pdtuTt2c10wbuPjtZxi3
         YkDM+lCNaOFeiQoWtxyT4+uri/VS8sWwCJ4OmB09J5kttdYrkcI50PQyiPx0IApxzS/6
         SQJK0z3GS8uH+V+YLbu3M9OSxdu4nbbYd6TijLfl8pL/VmJ01RTQZyLh9tEYANR4G+gQ
         Uryw==
X-Gm-Message-State: AOAM532RbZ0Gr39mCt9THRep4ZxQzj288d0fxaGR3Vasgon+YSrZpggK
        bZ0NhaCAvjwruZtuE3sAlInNTjuP4HlIowGclxPJwNcuvS4pDuBeaDnDcvJREaZ8F6wXPqtXj26
        9zStoMtgvwPCPixItar4CIfByV5krZfJyZvxI
X-Received: by 2002:a05:6402:1744:: with SMTP id v4mr48796865edx.366.1635926244381;
        Wed, 03 Nov 2021 00:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwe0XIxTe6tVJf3zXfhb55WCXz0RozpQEQABaBFbqc/OyKjh1IO4qGW8RiN8j1pQ4kbb58QZOOQpmbYpzAvPes=
X-Received: by 2002:a05:6402:1744:: with SMTP id v4mr48796842edx.366.1635926244113;
 Wed, 03 Nov 2021 00:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
 <20211013155926.GC6260@fieldses.org> <53AEBF77-7470-4B52-B69E-3CC515C3F393@oracle.com>
 <CALF+zOmXc+bidhaOMtUE_SOh+brGPuoScPU3E6KYc6tV52EMXg@mail.gmail.com> <8B619507-4BB3-48A8-9124-8501302CAA59@oracle.com>
In-Reply-To: <8B619507-4BB3-48A8-9124-8501302CAA59@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 3 Nov 2021 03:56:47 -0400
Message-ID: <CALF+zOkoQwyr5UFXjQnb-DSRXQeQQs3S4hVfs4ZS9PoSzTyXUA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Deprecate dprintk in svcrdma
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 13, 2021 at 5:03 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Oct 13, 2021, at 2:35 PM, David Wysochanski <dwysocha@redhat.com> wrote:
> >
> > On Wed, Oct 13, 2021 at 12:50 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >>
> >>
> >>> On Oct 13, 2021, at 11:59 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> >>>
> >>> On Wed, Oct 13, 2021 at 10:46:49AM -0400, Chuck Lever wrote:
> >>>> This patch series moves forward with the removal of dprintk in
> >>>> SUNRPC in favor of tracepoints. This is the last step for the
> >>>> svcrdma component.
> >>>
> >>> Makes sense to me.
> >>>
> >>> I would like some (very short) documentation, somewhere.  Partly just
> >>> for my sake!  I'm not sure exactly what to recommend to bug reporters.
> >>>
> >>> I guess
> >>>
> >>>      trace-cmd record -e 'sunrpc:*'
> >>>      trace-cmd report
> >>>
> >>> would be a rough substitute for "rpcdebug -m rpc -s all"?
> >>
> >> It would, but tracepoints can be enabled one event
> >> at a time. If you're looking for a direct replacement
> >> for a specific rpcdebug invocation, it might be better
> >> to examine the current sunrpc debug facilities and
> >> provide specific command lines to mimic those.
> >>
> >> "rpcdebug -vh" gives us:
> >>
> >> rpc        xprt call debug nfs auth bind sched trans svcsock svcdsp misc cache all
> >> nfs        vfs dircache lookupcache pagecache proc xdr file root callback client mount fscache pnfs pnfs_ld state all
> >> nfsd       sock fh export svc proc fileop auth repcache xdr lockd all
> >> nlm        svc client clntlock svclock monitor clntsubs svcsubs hostcache xdr all
> >>
> >>
> >> If tracepoints are named carefully, we can provide
> >> specific command lines to enable them as groups. So,
> >> for instance, I was thinking rpcdebug might display:
> >>
> >>        trace-cmd list | grep svcrdma
> >>
> >> to list tracepoints related to server side RDMA, or:
> >>
> >>        trace-cmd list | grep svcsock
> >>
> >> to show tracepoints related to server side sockets.
> >> Then:
> >>
> >>        trace-cmd record -e sunrpc:svcsock\*
> >>
> >> enables just the socket-related trace events, which
> >> coincidentally happens to line up with:
> >>
> >>        rpcdebug -m rpc -s svcsock
> >>
> >>
> >>> Do we have a couple examples of issues that could be diagnosed with
> >>> tracepoints?
> >>
> >> Anything you can do with dprintk you can do with trace
> >> points. Plus because tracepoints are lower overhead, they
> >> can be enabled and used in production environments,
> >> unlike dprintk.
> >>
> >> Also, tracepoints can trigger specific user space actions
> >> when they fire. You could for example set up a tracepoint
> >> in the RPC client that fires when a retransmit timeout
> >> occurs, and it could trigger a script to start tcpdump.
> >>
> >>
> >>> In the past I don't feel like I've ended up using dprintks
> >>> all that much; somehow they're not usually where I need them.  But maybe
> >>> that's just me.  And maybe as we put more thought into where tracepoints
> >>> should be, they'll get more useful.
> >>
> >>> Documentation/filesystems/nfs/, or the linux-nfs wiki, could be easy
> >>> places to put it.  Though *something* in the man pages would be nice.
> >>> At a minimum, a warning in rpcdebug(8) that we're gradually phasing out
> >>> dprintks.
> >>
> >> As I understood the conversation last week, SteveD and
> >> DaveW volunteered to be responsible for changes to
> >> rpcdebug?
> >>
> >
> > Well I don't remember it exactly like that, but it's probably close.
> >
> > I made a suggestion for the last kernel patch that deprecates any
> > rpcdebug facility, to leave one dfprintk in, stating there is no
> > information in the kernel anymore for this facility, so not to expect
> > this rpcdebug flag to produce any meaningful debug output, and
> > possibly redirect to ftrace facilities.  I brought that idea up
> > because of my fscache patches which totally removed the last dfprintk
> > in NFS fscache, and I wasn't sure what the deprecation procedure
> > was.  As I recall you didn't like that idea as it was never done before
> > with other rpcdebug flag deprecations, and it was shot down.
> >
> > I suppose we could put the same type of userspace patch to rpcdebug
> > that looks for kernel versions and prints a message if someone tries
> > to use a deprecated flag?  Would that be better?
>
> I don't recall discussing leaving one dprintk in place for
> each facility. My impression is that changing rpcdebug in
> this manner is what was decided during that conversation.
>

Just to follow up on this since I think this was an action item more
appropriate for me.
FYI, I have spoken to a couple Red Hat support engineers and asked
them to work on:
1. man page update for rpcdebug
2. rpcdebug warning if a flag is enabled on a kernel that does not
produce any output

They are making good progress and I hope they will post something to
the list within week or two.



>
> >> So far we haven't had much documentation for dprintk. That
> >> means we are starting more or less from scratch for
> >> explaining observability in the NFS stacks. Free rein, and
> >> all that.
> >>
> >> --
> >> Chuck Lever
>
> --
> Chuck Lever
>
>
>

