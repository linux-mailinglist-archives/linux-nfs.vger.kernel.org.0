Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0E62EA012
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 23:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhADWe4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 17:34:56 -0500
Received: from fieldses.org ([173.255.197.46]:49282 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbhADWe4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Jan 2021 17:34:56 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 7E7E16C79; Mon,  4 Jan 2021 17:34:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7E7E16C79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1609799653;
        bh=PznhEFjVFdaYNJvtqOYWMubQ7Vg/3tl3NsMf3a/Yq50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxddldTjIl8raBVpAW1eLo4swh61M7zN12XIKgHPZTbNvVYJ3JxEPL5Z/XUFV5HGB
         J52p5het93t6PL4UgF6+Z7t7ohrpkHzOQIhBaPb/7P2YbhScHe8iU86kxz8XOuwCHV
         D4nDk5JKo3vaOKe1khhKWlS+4vG5nc1bAzzOdrEs=
Date:   Mon, 4 Jan 2021 17:34:13 -0500
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] nfsd: protect concurrent access to nfsd stats
 counters
Message-ID: <20210104223413.GB27763@fieldses.org>
References: <20201228170344.22867-1-amir73il@gmail.com>
 <20201228170344.22867-2-amir73il@gmail.com>
 <20210104215528.GA27763@fieldses.org>
 <CAOQ4uxg_ZMPp_Huh3RS=bmFzoNtLicFdkoOQfZni9g_o+CBhDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg_ZMPp_Huh3RS=bmFzoNtLicFdkoOQfZni9g_o+CBhDg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 05, 2021 at 12:22:27AM +0200, Amir Goldstein wrote:
> On Mon, Jan 4, 2021 at 11:55 PM J . Bruce Fields <bfields@fieldses.org> wrote:
> >
> > Thanks for looking at this, it's long overdue!
> >
> > On Mon, Dec 28, 2020 at 07:03:43PM +0200, Amir Goldstein wrote:
> > > nfsd stats counters can be updated by concurrent nfsd threads without any
> > > protection.
> > >
> > > Convert some nfsd_stats and nfsd_net struct members to use percpu counters.
> > >
> > > There are several members of struct nfsd_stats that are reported in file
> > > /proc/net/rpc/nfsd by never updated. Those have been left untouched.
> >
> > Looking through the history, the code that updated fh_lookup, for
> > example, was removed in 2002.
> >
> > I'd be OK with removing those entirely, maybe just leave a /* deprecated
> > field */ comment where we printk the hard-coded 0's.  If somebody wants
> > to know more they can still find the answers in git.
> >
> 
> Sure. I can send a followup patch.
> 
> > > The longest_chain* members of struct nfsd_net remain unprotected.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/nfsd/netns.h    | 20 +++++++----
> > >  fs/nfsd/nfs4proc.c |  2 +-
> > >  fs/nfsd/nfscache.c | 52 +++++++++++++++++++--------
> > >  fs/nfsd/nfsctl.c   |  5 ++-
> > >  fs/nfsd/nfsfh.c    |  2 +-
> > >  fs/nfsd/stats.c    | 87 ++++++++++++++++++++++++++++++++++++----------
> > >  fs/nfsd/stats.h    | 42 +++++++++++++++-------
> > >  fs/nfsd/vfs.c      |  4 +--
> > >  8 files changed, 156 insertions(+), 58 deletions(-)
> > >
> > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > index 7346acda9d76..080c5389b2e7 100644
> > > --- a/fs/nfsd/netns.h
> > > +++ b/fs/nfsd/netns.h
> > > @@ -10,6 +10,7 @@
> > >
> > >  #include <net/net_namespace.h>
> > >  #include <net/netns/generic.h>
> > > +#include <linux/percpu_counter.h>
> > >
> > >  /* Hash tables for nfs4_clientid state */
> > >  #define CLIENT_HASH_BITS                 4
> > > @@ -149,20 +150,25 @@ struct nfsd_net {
> > >
> > >       /*
> > >        * Stats and other tracking of on the duplicate reply cache.
> > > -      * These fields and the "rc" fields in nfsdstats are modified
> > > -      * with only the per-bucket cache lock, which isn't really safe
> > > -      * and should be fixed if we want the statistics to be
> > > -      * completely accurate.
> > > +      * The longest_chain* fields are modified with only the per-bucket
> > > +      * cache lock, which isn't really safe and should be fixed if we want
> > > +      * these statistics to be completely accurate.
> > >        */
> > >
> > >       /* total number of entries */
> > >       atomic_t                 num_drc_entries;
> > >
> > > +     /* Reference to below counters as array for init/destroy */
> > > +     struct percpu_counter    counters[0];
> >
> > This feels slightly too clever for its own good, but....  OK, I see
> > there's a bunch of initializations to do in the nfsdstats case, and you
> > don't want to open code all that (and its error handling).  I guess I
> 
> Yeh, look at ceph_metric_init() and imagine what nfsdstats init
> would look like.
> 
> > don't have a better idea.  Is this a common pattern elsewhere?
> >
> 
> Sort of. Inspired by xfsstats and related macros (fs/xfs/xfs_stats.h).
> I have tried several approaches and this one ended up being the
> cleanest and smallest patch.
> 
> The cleaner way would be an actual percpu_counter array and
> convert all callers to use enum index to array like the dqstats counters
> (include/linux/quota.h), but IMO current patch is enough.

OK, I can live with that.

--b.
