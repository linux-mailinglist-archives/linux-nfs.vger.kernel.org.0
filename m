Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B223D2EAE9D
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbhAEPfG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 10:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbhAEPfG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 10:35:06 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE7CC061574
        for <linux-nfs@vger.kernel.org>; Tue,  5 Jan 2021 07:34:26 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0EB266E9D; Tue,  5 Jan 2021 10:34:25 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0EB266E9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1609860865;
        bh=jx3IyOotcjkYyiI4isILQJ4ulv82BPMcwlNtQbNU3FY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/MqN9QsFHv+bIBhzSD65q+OjMBZS/+yK0zG/K/yHFTH1eRSzkftZSk/C6VugzWqW
         dxxkFNDhS0BwLnDoS9z3E/T8J0qC3youudUtRQl6bcqlLFihQHFht4yXtzYk/VGP9A
         8Q+Q/p0w7EI9REoDuxA+C9uebD/vqPqEIw07rH1U=
Date:   Tue, 5 Jan 2021 10:34:25 -0500
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] nfsd: report per-export stats
Message-ID: <20210105153425.GB14893@fieldses.org>
References: <20201228170344.22867-1-amir73il@gmail.com>
 <20201228170344.22867-3-amir73il@gmail.com>
 <20210104224930.GC27763@fieldses.org>
 <CAOQ4uxh18YYN=T3Ua3Bia=N+zw7RjGctnJqyyEDE53dp-p2Kuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh18YYN=T3Ua3Bia=N+zw7RjGctnJqyyEDE53dp-p2Kuw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 05, 2021 at 08:42:21AM +0200, Amir Goldstein wrote:
> On Tue, Jan 5, 2021 at 12:49 AM J . Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Mon, Dec 28, 2020 at 07:03:44PM +0200, Amir Goldstein wrote:
> > > Collect some nfsd stats per export in addition to the global stats.
> >
> > Seems like a reasonable thing to do.
> >
> > > A new nfsdfs export_stats file is created.  It uses the same ops as the
> > > exports file to iterate the export entries and we use the file's name to
> > > determine the reported info per export.  For example:
> > >
> > >  $ cat /proc/fs/nfsd/export_stats
> > >  # Version 1.1
> > >  # Path Client Start-time
> > >  #    Stats
> > >  /test        localhost       92
> > >       fh_stale: 0
> > >       io_read: 9
> > >       io_write: 1
> > >
> > > Every export entry reports the start time when stats collection
> > > started, so stats collecting scripts can know if stats where reset
> > > between samples.
> >
> > Yes, you expect svc_export to be created (or destroyed) when a
> > filesystem is exported (or unexported), or when nfsd starts (or stops).
> >
> > But actually it's just a cache entry and can be removed and recreated at
> > any time.  Not much we can do about losing statistics when that happens,
> > but the start time at least gives us some hope of interpreting the
> > statistics.
> >
> > Why weren't there existing file system statistics that would do the job
> > in your case?
> >
> 
> I am not sure what you mean.
> We want to know the amount of read/write io for a specific export on
> the server, including io to/from page cache, which isn't counted by stats
> of most local filesystems.

I was just curious what exactly your use case was.  (And incidentally
if it explained the interest in STALE errors as well?)

> Unrelated, in our search for those statistics, we were surprised (good
> surprises)
> to learn about s_op->show_stats(), but also surprised (bad surprise)
> to learn how few filesystems implement this method.

Yes, Chuck added it for NFS (checks history...) in 2006.  NFS is unique
in some ways, but I can imagine it'd be useful elsewhere too.

--b.
