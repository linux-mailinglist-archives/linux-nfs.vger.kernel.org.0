Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836A82ED211
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jan 2021 15:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbhAGO0L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jan 2021 09:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbhAGO0L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jan 2021 09:26:11 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B40C0612F4
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jan 2021 06:25:30 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5B32E6191; Thu,  7 Jan 2021 09:25:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5B32E6191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1610029529;
        bh=0lGKsJW2J/fRuHuQGA52TNJmCyFyxm2KuUejJWmi4uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snwalCJLMoWX8/4fPqr9qxKUiNQU9+e8ObwFeGe3hWLYEufVb7AruVSFWtqwfoyMo
         0M3FH/iceCG85X1rg/74CVNQ1OEpJqFmb49YT9BoMZTWGQhlhgaltvF/t/SU0HLtIT
         DEq+KQ3xbkb2w9Xb/gIFarE3Xr7GTwWeepaNq//w=
Date:   Thu, 7 Jan 2021 09:25:29 -0500
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] nfsd: protect concurrent access to nfsd stats
 counters
Message-ID: <20210107142529.GA5730@fieldses.org>
References: <20210106075236.4184-1-amir73il@gmail.com>
 <20210106075236.4184-3-amir73il@gmail.com>
 <20210106205017.GG13116@fieldses.org>
 <CAOQ4uxgh=f7fQ6Zf6ry8tC-WXMEoZzTo50y+K56paLTyadV7yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgh=f7fQ6Zf6ry8tC-WXMEoZzTo50y+K56paLTyadV7yw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 07, 2021 at 09:17:42AM +0200, Amir Goldstein wrote:
> On Wed, Jan 6, 2021 at 10:50 PM J . Bruce Fields <bfields@fieldses.org> wrote:
> >
> > These three patches seem fine.  To bikeshed just a bit more:
> >
> > On Wed, Jan 06, 2021 at 09:52:35AM +0200, Amir Goldstein wrote:
> > >       /* We found a matching entry which is either in progress or done. */
> > > -     nfsdstats.rchits++;
> > > +     nfsd_stats_rc_hits_inc();
> >
> > Maybe make that something like
> >
> >         nfsd_stats_inc(NFSD_STATS_RC_HITS);
> >
> > and then we could avoid boilerplate like the below?
> >
> 
> It looks like boilerplate, but every helper is a bit different,
> so we would have to introduce several variants like:
> 
>          nfsd_net_stats_inc(nn, NFSD_NET_PAYLOAD_MISSES);
> 
> Which is the way I started, but realized it opens a big hole for
> human mistakes in the form of:
> 
>          nfsd_net_stats_inc(nn, NFSD_STATS_RC_HITS);
>          nfsd_stats_inc(NFSD_NET_PAYLOAD_MISSES);
> 
> And we have no way to detect those errors at compile time
> because enum types are not strict types.
> 
> Also, in the next patch, three more helpers become unique
> as they are made into helpers to account for both global and per-export
> stats (fh_stale, io_read, io_write).
> Making those helpers generic would require aligning the start of global
> stats enum values with the per-export enum values and that is a source
> of more human errors.
> 
> See the end result of stats.h. All the helpers are unique and the only ones
> that remain generic are nfsd_stats_rc_*.
> Making those generic would also require checking the range of the index
> value is in the NFSD_STATS_RC_* range.
> 
> I also tried a version with boilerplate defining macros, i.e.:
> 
> NFSD_STATS_FUNCS(rc_hits, RC_HITS)
> NFSD_STATS_FUNCS(fh_stale, FH_STALE)
> NFSD_STATS_FUNCS(io_read, IO_READ)
> 
> But when I realized in the end it can only serve the rc_* counters,
> I dropped it.

Yeah, OK.  I'm not a fan of that kind of macro use, either.  It's made
me waste time when "grep" doesn't turn up a function definition, for
example.

> Thoughts?

I've got no clever alternative, and you've tried a lot of alternatives,
so I'll trust your judgement.  Thanks for the explanation.

--b.
