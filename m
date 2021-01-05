Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4E2EB2A3
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 19:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbhAEScq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 13:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbhAEScq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 13:32:46 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04E2C061574
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 10:32:05 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id AEFC96E99; Tue,  5 Jan 2021 13:32:04 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org AEFC96E99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1609871524;
        bh=vABwaO9Nz0ylHlBnO0MrIZGwOkGr9F/nxWSnrlWin3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wUsGu/G80Rr2JHLqyEfgv7K1JIgM1+/2YwI6s4z9Vre8t9T29oLGdlYEKEgy7MlQg
         y3EaqOJuej7dNJfz1sBCdngAC3gHr354ezaL6hhV8UGiyXPjFCw/JzR6ioVcJlwAJ7
         lIvFhsLlEgic6VFvc2+6eG9mGWju0LIrG+v10R98=
Date:   Tue, 5 Jan 2021 13:32:04 -0500
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] nfsd: report per-export stats
Message-ID: <20210105183204.GD14893@fieldses.org>
References: <20201228170344.22867-1-amir73il@gmail.com>
 <20201228170344.22867-3-amir73il@gmail.com>
 <20210104224930.GC27763@fieldses.org>
 <CAOQ4uxh18YYN=T3Ua3Bia=N+zw7RjGctnJqyyEDE53dp-p2Kuw@mail.gmail.com>
 <20210105153425.GB14893@fieldses.org>
 <CAOQ4uxhJA93JeNMHB5-Enhx1t-ZirRHs7MHtL02jhg8DAEz9BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhJA93JeNMHB5-Enhx1t-ZirRHs7MHtL02jhg8DAEz9BA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 05, 2021 at 05:45:07PM +0200, Amir Goldstein wrote:
> On Tue, Jan 5, 2021 at 5:34 PM J . Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Tue, Jan 05, 2021 at 08:42:21AM +0200, Amir Goldstein wrote:
> > > On Tue, Jan 5, 2021 at 12:49 AM J . Bruce Fields <bfields@fieldses.org> wrote:
> > > >
> > > > On Mon, Dec 28, 2020 at 07:03:44PM +0200, Amir Goldstein wrote:
> > > > > Collect some nfsd stats per export in addition to the global stats.
> > > >
> > > > Seems like a reasonable thing to do.
> > > >
> > > > > A new nfsdfs export_stats file is created.  It uses the same ops as the
> > > > > exports file to iterate the export entries and we use the file's name to
> > > > > determine the reported info per export.  For example:
> > > > >
> > > > >  $ cat /proc/fs/nfsd/export_stats
> > > > >  # Version 1.1
> > > > >  # Path Client Start-time
> > > > >  #    Stats
> > > > >  /test        localhost       92
> > > > >       fh_stale: 0
> > > > >       io_read: 9
> > > > >       io_write: 1
> > > > >
> > > > > Every export entry reports the start time when stats collection
> > > > > started, so stats collecting scripts can know if stats where reset
> > > > > between samples.
> > > >
> > > > Yes, you expect svc_export to be created (or destroyed) when a
> > > > filesystem is exported (or unexported), or when nfsd starts (or stops).
> > > >
> > > > But actually it's just a cache entry and can be removed and recreated at
> > > > any time.  Not much we can do about losing statistics when that happens,
> > > > but the start time at least gives us some hope of interpreting the
> > > > statistics.
> > > >
> > > > Why weren't there existing file system statistics that would do the job
> > > > in your case?
> > > >
> > >
> > > I am not sure what you mean.
> > > We want to know the amount of read/write io for a specific export on
> > > the server, including io to/from page cache, which isn't counted by stats
> > > of most local filesystems.
> >
> > I was just curious what exactly your use case was.  (And incidentally
> > if it explained the interest in STALE errors as well?)
> 
> Ah no I don't. I just added it as a public service.
> Do you prefer that I drop fh_stale from per-export stats?

No, I've got no objection to it.

--b.

> 
> >
> > > Unrelated, in our search for those statistics, we were surprised (good
> > > surprises)
> > > to learn about s_op->show_stats(), but also surprised (bad surprise)
> > > to learn how few filesystems implement this method.
> >
> > Yes, Chuck added it for NFS (checks history...) in 2006.  NFS is unique
> > in some ways, but I can imagine it'd be useful elsewhere too.
> >
> 
> Well, we are exporting fuse, so I considered adding ->show_stats() for fuse,
> but per export stats is MUCH easier ;-)
> 
> Thanks,
> Amir.
