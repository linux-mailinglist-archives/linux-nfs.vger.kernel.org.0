Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A132EA0C1
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 00:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbhADXZ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 18:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbhADXZ7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 18:25:59 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D4C061793
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jan 2021 15:25:18 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id t9so26995418ilf.2
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jan 2021 15:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+/tXTkPbAHGM7VVx7QvQuP1rZfaFF5gik/dBPqmyTk=;
        b=alCqMIRBwqrsPuJWAMzCU95UrGS07n2jHqlCZ7a0mGArE0pDLCqqnAHb8U9smGDktV
         ExLTlW43LzjFVpaT+ZePwma/62AzdgcLl9ooTUNuyFxCtL5zwOz0WVYtMX+wzpfTG5V6
         ZBdxrK2Yd35keh/hjBfKILMhzys8+XgGR1FygyCsY1CwnEnSbNE3k3eGvleLz+gkeOOu
         WpeiidLcX5xhcz8zBMMDVpPAp4tVR0s3fhRm4YO7ylm0UzIi1vRj/nrxmzAO6oSalAot
         KTIerRLswCX5hxbsJIl4yUFqsBBKlN8YsI0+1i4VG4dV8tBlGTChQ2KhxJuIaZgEz6Ne
         MVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+/tXTkPbAHGM7VVx7QvQuP1rZfaFF5gik/dBPqmyTk=;
        b=TDh0DitWUurn1redeTbEe7znBdl+Qt0Ilw+hMVkTA5n3xU9VnHbh2hi9zD76eP+puv
         FeCxMNHlWHzocNVogHBOCx+jXB3WHvXFV4WVCItp95Y3YtlSZgOIuww1Itrj5iWJQ3bU
         aRvkNHex8w7FS/KntBxk3gaAXvciuqbJctd0lf5j/8hfgTM1LmMe73sxKGKzihZ07hU6
         MtG0R20/Ip5ky7jKx8se+5sMQCS+blHxi6+f++8M/YmohBJefLgGo1SSdM6F+nAt43FY
         ut5cmNA2nfxjbgLhzp1QoGvi+3JbxFrA+s0Ne56J7iVw8snvvUsNFFEN8QTaAJ08/DsE
         eqVQ==
X-Gm-Message-State: AOAM530cCg3YNqc3M8R1M7NP9FzwIfOBHZRq3GS8U4YGR975qwsyZrJE
        9FeeigdIDIdvz7SJsnhhvgKmK/SQn8MNRsK2lqyxm2qIoiQ=
X-Google-Smtp-Source: ABdhPJwmzoh0qkibJVX9MtIPL8KlAQOZ7I/O694+3t2q/JhLvg+6+kPP3mUe9EhYAJNAzf0OGrM24a5DJ/MD3TCNNh8=
X-Received: by 2002:a6b:fd03:: with SMTP id c3mr60801935ioi.64.1609798958596;
 Mon, 04 Jan 2021 14:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20201228170344.22867-1-amir73il@gmail.com> <20201228170344.22867-2-amir73il@gmail.com>
 <20210104215528.GA27763@fieldses.org>
In-Reply-To: <20210104215528.GA27763@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 Jan 2021 00:22:27 +0200
Message-ID: <CAOQ4uxg_ZMPp_Huh3RS=bmFzoNtLicFdkoOQfZni9g_o+CBhDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nfsd: protect concurrent access to nfsd stats counters
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 4, 2021 at 11:55 PM J . Bruce Fields <bfields@fieldses.org> wrote:
>
> Thanks for looking at this, it's long overdue!
>
> On Mon, Dec 28, 2020 at 07:03:43PM +0200, Amir Goldstein wrote:
> > nfsd stats counters can be updated by concurrent nfsd threads without any
> > protection.
> >
> > Convert some nfsd_stats and nfsd_net struct members to use percpu counters.
> >
> > There are several members of struct nfsd_stats that are reported in file
> > /proc/net/rpc/nfsd by never updated. Those have been left untouched.
>
> Looking through the history, the code that updated fh_lookup, for
> example, was removed in 2002.
>
> I'd be OK with removing those entirely, maybe just leave a /* deprecated
> field */ comment where we printk the hard-coded 0's.  If somebody wants
> to know more they can still find the answers in git.
>

Sure. I can send a followup patch.

> > The longest_chain* members of struct nfsd_net remain unprotected.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/nfsd/netns.h    | 20 +++++++----
> >  fs/nfsd/nfs4proc.c |  2 +-
> >  fs/nfsd/nfscache.c | 52 +++++++++++++++++++--------
> >  fs/nfsd/nfsctl.c   |  5 ++-
> >  fs/nfsd/nfsfh.c    |  2 +-
> >  fs/nfsd/stats.c    | 87 ++++++++++++++++++++++++++++++++++++----------
> >  fs/nfsd/stats.h    | 42 +++++++++++++++-------
> >  fs/nfsd/vfs.c      |  4 +--
> >  8 files changed, 156 insertions(+), 58 deletions(-)
> >
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 7346acda9d76..080c5389b2e7 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -10,6 +10,7 @@
> >
> >  #include <net/net_namespace.h>
> >  #include <net/netns/generic.h>
> > +#include <linux/percpu_counter.h>
> >
> >  /* Hash tables for nfs4_clientid state */
> >  #define CLIENT_HASH_BITS                 4
> > @@ -149,20 +150,25 @@ struct nfsd_net {
> >
> >       /*
> >        * Stats and other tracking of on the duplicate reply cache.
> > -      * These fields and the "rc" fields in nfsdstats are modified
> > -      * with only the per-bucket cache lock, which isn't really safe
> > -      * and should be fixed if we want the statistics to be
> > -      * completely accurate.
> > +      * The longest_chain* fields are modified with only the per-bucket
> > +      * cache lock, which isn't really safe and should be fixed if we want
> > +      * these statistics to be completely accurate.
> >        */
> >
> >       /* total number of entries */
> >       atomic_t                 num_drc_entries;
> >
> > +     /* Reference to below counters as array for init/destroy */
> > +     struct percpu_counter    counters[0];
>
> This feels slightly too clever for its own good, but....  OK, I see
> there's a bunch of initializations to do in the nfsdstats case, and you
> don't want to open code all that (and its error handling).  I guess I

Yeh, look at ceph_metric_init() and imagine what nfsdstats init
would look like.

> don't have a better idea.  Is this a common pattern elsewhere?
>

Sort of. Inspired by xfsstats and related macros (fs/xfs/xfs_stats.h).
I have tried several approaches and this one ended up being the
cleanest and smallest patch.

The cleaner way would be an actual percpu_counter array and
convert all callers to use enum index to array like the dqstats counters
(include/linux/quota.h), but IMO current patch is enough.

Thanks,
Amir.
