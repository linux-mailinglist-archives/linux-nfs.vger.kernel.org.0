Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1442EAF2C
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbhAEPqA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbhAEPqA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:46:00 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC916C061793
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:45:19 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id x15so83822ilq.1
        for <linux-nfs@vger.kernel.org>; Tue, 05 Jan 2021 07:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxBwAQNpA/QLgsDE2xdalekEFx5UAENV5gVw2ZBSPPs=;
        b=GoW95tGkAqg5yW1Wbr2b2RfZgi6Dl3BZt9BgUn1LreYuzgb85SVqqAvZz0uQUjL0EI
         irwZdvn1QKhYlsApf1ij3lBjy26BrFEHzDeQcOmKTiVBc0dWgdo2P9CrptP2WbByBXHG
         2ZgP1sAVJlONnNQ3olqnK17OgtLr2PB54twK5oCGytWNIaKHmGheP2Vqa2SOo7LxJBJc
         HhqhgH7b9VGfHUrjEHXV/eZhJyNQ+Vz+7sYDubKRc1SN5urkVtu2MEghR2qu0VMFdqMW
         a2eOR1f91AnSzpy4XQa7jE5cQ+VG8geKPGa3txLPFWiwXp43w2t5q/RthSSy4Q+gO0gy
         GsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxBwAQNpA/QLgsDE2xdalekEFx5UAENV5gVw2ZBSPPs=;
        b=VJ4W6+EzIJtK+QhYkCwv5rEvd1fbVm+7mSwFGibDP5qLzjadpBwMnixYwKvcyCG6dA
         A5Xr77yHeax+zT4FYI/c3HdyS1EKSdj+9CtWAgDx4JA614yAVarETZeXaHMUJ6i0qdBH
         Zg3VBNnLw9Gl+IBtHyL9fDbDvnt+SZz8UoHguUrmV6i4w7MKmGiyBFgJnW9FAcDztPfj
         mE+zZH3Q+PC8HeYZgPqQm+OXboQhEVN66XMl0x67zsm4iEnoal4SSyOvTMeltb9qZGu1
         rQD9eCi7vnuIiWiZb0s4SoJzXcFOdp4Tf73MNaQx5ga6YAv6vHbB4fotTgTh0qJjDFPm
         ts1w==
X-Gm-Message-State: AOAM533JlwxZZSHuc3ogSVuSRsQhR4cu4nd/UwOvWJtnNWX3vTdYexBo
        CP4iSa+wx79gqwLexvzoWB2mSkpo16HbMqoZEngRVu2v
X-Google-Smtp-Source: ABdhPJyNhhRA362FQg6dIdeTy7DtHahFfNwnKwOWI7tXDonVE5tJ+szAK6rOY8+NzXUqxkPIuZa+A+AhSpWTV3vnkbA=
X-Received: by 2002:a05:6e02:1a8e:: with SMTP id k14mr181439ilv.275.1609861519106;
 Tue, 05 Jan 2021 07:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20201228170344.22867-1-amir73il@gmail.com> <20201228170344.22867-3-amir73il@gmail.com>
 <20210104224930.GC27763@fieldses.org> <CAOQ4uxh18YYN=T3Ua3Bia=N+zw7RjGctnJqyyEDE53dp-p2Kuw@mail.gmail.com>
 <20210105153425.GB14893@fieldses.org>
In-Reply-To: <20210105153425.GB14893@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 Jan 2021 17:45:07 +0200
Message-ID: <CAOQ4uxhJA93JeNMHB5-Enhx1t-ZirRHs7MHtL02jhg8DAEz9BA@mail.gmail.com>
Subject: Re: [PATCH 2/2] nfsd: report per-export stats
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 5, 2021 at 5:34 PM J . Bruce Fields <bfields@fieldses.org> wrote:
>
> On Tue, Jan 05, 2021 at 08:42:21AM +0200, Amir Goldstein wrote:
> > On Tue, Jan 5, 2021 at 12:49 AM J . Bruce Fields <bfields@fieldses.org> wrote:
> > >
> > > On Mon, Dec 28, 2020 at 07:03:44PM +0200, Amir Goldstein wrote:
> > > > Collect some nfsd stats per export in addition to the global stats.
> > >
> > > Seems like a reasonable thing to do.
> > >
> > > > A new nfsdfs export_stats file is created.  It uses the same ops as the
> > > > exports file to iterate the export entries and we use the file's name to
> > > > determine the reported info per export.  For example:
> > > >
> > > >  $ cat /proc/fs/nfsd/export_stats
> > > >  # Version 1.1
> > > >  # Path Client Start-time
> > > >  #    Stats
> > > >  /test        localhost       92
> > > >       fh_stale: 0
> > > >       io_read: 9
> > > >       io_write: 1
> > > >
> > > > Every export entry reports the start time when stats collection
> > > > started, so stats collecting scripts can know if stats where reset
> > > > between samples.
> > >
> > > Yes, you expect svc_export to be created (or destroyed) when a
> > > filesystem is exported (or unexported), or when nfsd starts (or stops).
> > >
> > > But actually it's just a cache entry and can be removed and recreated at
> > > any time.  Not much we can do about losing statistics when that happens,
> > > but the start time at least gives us some hope of interpreting the
> > > statistics.
> > >
> > > Why weren't there existing file system statistics that would do the job
> > > in your case?
> > >
> >
> > I am not sure what you mean.
> > We want to know the amount of read/write io for a specific export on
> > the server, including io to/from page cache, which isn't counted by stats
> > of most local filesystems.
>
> I was just curious what exactly your use case was.  (And incidentally
> if it explained the interest in STALE errors as well?)

Ah no I don't. I just added it as a public service.
Do you prefer that I drop fh_stale from per-export stats?

>
> > Unrelated, in our search for those statistics, we were surprised (good
> > surprises)
> > to learn about s_op->show_stats(), but also surprised (bad surprise)
> > to learn how few filesystems implement this method.
>
> Yes, Chuck added it for NFS (checks history...) in 2006.  NFS is unique
> in some ways, but I can imagine it'd be useful elsewhere too.
>

Well, we are exporting fuse, so I considered adding ->show_stats() for fuse,
but per export stats is MUCH easier ;-)

Thanks,
Amir.
