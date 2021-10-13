Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C2942C8C8
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 20:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhJMSiI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 14:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231434AbhJMSiH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Oct 2021 14:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634150162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WtTjvZoybaHgq8qFKTcrnsgPksKO58vSEK+1x14wmrI=;
        b=Hoog2KfEmUP0eRVhcpOJK6cgKfx0CtTQPs+bbRLMBU73s0afzPuL21jKPAWH/EQm8mM4ZW
        fHyMJuVeGtgd7nPv5NQVKUzq8QpVPUbEBqMIAKpNvugK2HVTX7WHTTMQZjBfbM10P1UAN6
        DXCzsCn0YjSH5efX1VRLhvybbH+8BfQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-mqraFdH6M9-yC49ZpwJP8A-1; Wed, 13 Oct 2021 14:36:01 -0400
X-MC-Unique: mqraFdH6M9-yC49ZpwJP8A-1
Received: by mail-ed1-f71.google.com with SMTP id z23-20020aa7cf97000000b003db7be405e1so3049037edx.13
        for <linux-nfs@vger.kernel.org>; Wed, 13 Oct 2021 11:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtTjvZoybaHgq8qFKTcrnsgPksKO58vSEK+1x14wmrI=;
        b=E3nDmtEkEyicSqjRxHkYBYsDElU0y7Adq/h4NVhniXyklZP7gO48NEOgzeTfxqzRwh
         0lFKxRv3m2IwIMnQDepspC7BUldk7LK7CHoY9AWUsvYppr0JxwMIBl9xsKw5WOMYSZKH
         wMD0WPTp8GIG3+kDA+OCUIK3NEe157TySPjIiGNjF8XBEGhifiWsoOfcy0pUm/5vLDVu
         WH1RfKB/DfAce56C3yOnI9u7ZMdBRGnypJmQRQOgRiHNBEvAciMJY3VTXudTQG5Zj8Xk
         5K/J4ov1kyPCvvCvvoiw8tnobpXzraKGcToseK15CIK/HCb9B2KjM/Ue6pbV/r23g9vz
         Nrlg==
X-Gm-Message-State: AOAM530cYsvdkXG8UhfJSq6ehDbzuerokBvOaESN4WIK8jfL3XZcDHTB
        uLNWzp2bnQQZpkV+F4Ba+hFbCEEgwOih0nFmY97l0fbVNoS46j3fj8fYwe/xW1iceIXy6LKNTcG
        gemAXato7BYD+Cje4snEb64H+udA/SbZhkQp7
X-Received: by 2002:a17:906:5e17:: with SMTP id n23mr1038525eju.258.1634150160100;
        Wed, 13 Oct 2021 11:36:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnDhKMa3t7i6NIZhd7vYEneTinsYFJIBJ4KxH12GcspVBkjCrcz5UhxDiSbFTjVaxKOXlTdQ1AVgH4onlbA60=
X-Received: by 2002:a17:906:5e17:: with SMTP id n23mr1038501eju.258.1634150159819;
 Wed, 13 Oct 2021 11:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
 <20211013155926.GC6260@fieldses.org> <53AEBF77-7470-4B52-B69E-3CC515C3F393@oracle.com>
In-Reply-To: <53AEBF77-7470-4B52-B69E-3CC515C3F393@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 13 Oct 2021 14:35:23 -0400
Message-ID: <CALF+zOmXc+bidhaOMtUE_SOh+brGPuoScPU3E6KYc6tV52EMXg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Deprecate dprintk in svcrdma
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 13, 2021 at 12:50 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Oct 13, 2021, at 11:59 AM, J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Wed, Oct 13, 2021 at 10:46:49AM -0400, Chuck Lever wrote:
> >> This patch series moves forward with the removal of dprintk in
> >> SUNRPC in favor of tracepoints. This is the last step for the
> >> svcrdma component.
> >
> > Makes sense to me.
> >
> > I would like some (very short) documentation, somewhere.  Partly just
> > for my sake!  I'm not sure exactly what to recommend to bug reporters.
> >
> > I guess
> >
> >       trace-cmd record -e 'sunrpc:*'
> >       trace-cmd report
> >
> > would be a rough substitute for "rpcdebug -m rpc -s all"?
>
> It would, but tracepoints can be enabled one event
> at a time. If you're looking for a direct replacement
> for a specific rpcdebug invocation, it might be better
> to examine the current sunrpc debug facilities and
> provide specific command lines to mimic those.
>
> "rpcdebug -vh" gives us:
>
> rpc        xprt call debug nfs auth bind sched trans svcsock svcdsp misc cache all
> nfs        vfs dircache lookupcache pagecache proc xdr file root callback client mount fscache pnfs pnfs_ld state all
> nfsd       sock fh export svc proc fileop auth repcache xdr lockd all
> nlm        svc client clntlock svclock monitor clntsubs svcsubs hostcache xdr all
>
>
> If tracepoints are named carefully, we can provide
> specific command lines to enable them as groups. So,
> for instance, I was thinking rpcdebug might display:
>
>         trace-cmd list | grep svcrdma
>
> to list tracepoints related to server side RDMA, or:
>
>         trace-cmd list | grep svcsock
>
> to show tracepoints related to server side sockets.
> Then:
>
>         trace-cmd record -e sunrpc:svcsock\*
>
> enables just the socket-related trace events, which
> coincidentally happens to line up with:
>
>         rpcdebug -m rpc -s svcsock
>
>
> > Do we have a couple examples of issues that could be diagnosed with
> > tracepoints?
>
> Anything you can do with dprintk you can do with trace
> points. Plus because tracepoints are lower overhead, they
> can be enabled and used in production environments,
> unlike dprintk.
>
> Also, tracepoints can trigger specific user space actions
> when they fire. You could for example set up a tracepoint
> in the RPC client that fires when a retransmit timeout
> occurs, and it could trigger a script to start tcpdump.
>
>
> > In the past I don't feel like I've ended up using dprintks
> > all that much; somehow they're not usually where I need them.  But maybe
> > that's just me.  And maybe as we put more thought into where tracepoints
> > should be, they'll get more useful.
>
> > Documentation/filesystems/nfs/, or the linux-nfs wiki, could be easy
> > places to put it.  Though *something* in the man pages would be nice.
> > At a minimum, a warning in rpcdebug(8) that we're gradually phasing out
> > dprintks.
>
> As I understood the conversation last week, SteveD and
> DaveW volunteered to be responsible for changes to
> rpcdebug?
>

Well I don't remember it exactly like that, but it's probably close.

I made a suggestion for the last kernel patch that deprecates any
rpcdebug facility, to leave one dfprintk in, stating there is no
information in the kernel anymore for this facility, so not to expect
this rpcdebug flag to produce any meaningful debug output, and
possibly redirect to ftrace facilities.  I brought that idea up
because of my fscache patches which totally removed the last dfprintk
in NFS fscache, and I wasn't sure what the deprecation procedure
was.  As I recall you didn't like that idea as it was never done before
with other rpcdebug flag deprecations, and it was shot down.

I suppose we could put the same type of userspace patch to rpcdebug
that looks for kernel versions and prints a message if someone tries
to use a deprecated flag?  Would that be better?


> So far we haven't had much documentation for dprintk. That
> means we are starting more or less from scratch for
> explaining observability in the NFS stacks. Free rein, and
> all that.
>
> --
> Chuck Lever
>
>
>

