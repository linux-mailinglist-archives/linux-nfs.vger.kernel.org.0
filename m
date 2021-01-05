Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875402EA56D
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 07:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725298AbhAEGam (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 01:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbhAEGam (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 01:30:42 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C07CC061574
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jan 2021 22:30:02 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id z5so27265084iob.11
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jan 2021 22:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y70xdzfh7Rylsh5gquyDnvvwOUwdqnHpbhzpv3Ir7b4=;
        b=P9haN68tEOOEZx1AAkcXCcbfCV56Ev4oO6o8apxvdjVDiDu0LrlttLftSm00BAANbB
         KF/KtQKJWJcNDHaLQYoyZ4enp2AnuQRHaRNOXltN6NSx8rhZ23gNElvdIgU9qnx2XW8C
         3eak2mcmD1x8mmjprk/lKJeMgc9GLsmp4iEv+kYLmI33DsUDfP1t5WVVzl60w9egvcUJ
         SEjQmV3cONhH7DE3NR6VrdA3ivUa/j76OrXf+ZYY42QV4AuvcQCYMbmC3NQlbzM51C7B
         Yr77zdU8siiKxDUdmduXbUTT+pr3+L5w2mtyyrHc1/hjc1h2hleKyZuuQquPn8ztnHr+
         sZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y70xdzfh7Rylsh5gquyDnvvwOUwdqnHpbhzpv3Ir7b4=;
        b=Q+nt+g4xHxqZOjfrKTZxQT+CnJ6esxLueFhH9zvlXinawPmUHcLooiwt7GfL9G8IS0
         8SMz5Rdji4yYq13pDMHebtpY8juKhhe6QXNTPc9gNWCxJu3baI6KyWf3GUiwQ+EiN9i6
         WPv+WE9ko6AUBTR1SQLEq++upfZsNKFQY3KxGVQ1ri98Kpb3RdapVNiCJaij7WECuuW+
         HaSs7+RzHhHYYR7t7b5h6PfTvec/OjCtxEAwaheZQuEsJT63g8x0uEgJVTu11sTaYRk2
         L4OdL5MhUAHzbLAkvE7mzZM0RgBRHHNCJI66YRjolNOinWiFQmz45J5TKpjbq6TKFjtq
         TMgg==
X-Gm-Message-State: AOAM532Mine+PYH88J4hpeG3WH19GLbKo4D2xVEFtfvyJ35sZLkDjNGu
        bt5U/Y87ykG+nbYfvoJP6zKK1m1n3xOZoGUY29zAzpWI
X-Google-Smtp-Source: ABdhPJzq+V6dDI64xmP+KnYU+F4eg94dAFY0rV1yuDsaQr4gpq31DxALhyAnVWHHXw6ayshpeXCeZMG/lEEBFt+GBXU=
X-Received: by 2002:a02:cc89:: with SMTP id s9mr64815479jap.81.1609828201451;
 Mon, 04 Jan 2021 22:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20201228170344.22867-1-amir73il@gmail.com> <20201228170344.22867-2-amir73il@gmail.com>
 <20210104215528.GA27763@fieldses.org> <CAOQ4uxg_ZMPp_Huh3RS=bmFzoNtLicFdkoOQfZni9g_o+CBhDg@mail.gmail.com>
 <AF5EDF2D-6164-42A6-96E9-72E75D3F226A@oracle.com>
In-Reply-To: <AF5EDF2D-6164-42A6-96E9-72E75D3F226A@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 Jan 2021 08:29:50 +0200
Message-ID: <CAOQ4uxj_y+Q_n50sVeMC4xQ8fnmWdR6YVqpGSTxun0o9LBBc0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] nfsd: protect concurrent access to nfsd stats counters
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 5, 2021 at 4:12 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jan 4, 2021, at 5:22 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Jan 4, 2021 at 11:55 PM J . Bruce Fields <bfields@fieldses.org> wrote:
> >>
> >> Thanks for looking at this, it's long overdue!
> >>
> >> On Mon, Dec 28, 2020 at 07:03:43PM +0200, Amir Goldstein wrote:
> >>> nfsd stats counters can be updated by concurrent nfsd threads without any
> >>> protection.
> >>>
> >>> Convert some nfsd_stats and nfsd_net struct members to use percpu counters.
> >>>
> >>> There are several members of struct nfsd_stats that are reported in file
> >>> /proc/net/rpc/nfsd by never updated. Those have been left untouched.
> >>
> >> Looking through the history, the code that updated fh_lookup, for
> >> example, was removed in 2002.
> >>
> >> I'd be OK with removing those entirely, maybe just leave a /* deprecated
> >> field */ comment where we printk the hard-coded 0's.  If somebody wants
> >> to know more they can still find the answers in git.
> >>
> >
> > Sure. I can send a followup patch.
> >
> >>> The longest_chain* members of struct nfsd_net remain unprotected.
> >>>
> >>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >>> ---
> >>> fs/nfsd/netns.h    | 20 +++++++----
> >>> fs/nfsd/nfs4proc.c |  2 +-
> >>> fs/nfsd/nfscache.c | 52 +++++++++++++++++++--------
> >>> fs/nfsd/nfsctl.c   |  5 ++-
> >>> fs/nfsd/nfsfh.c    |  2 +-
> >>> fs/nfsd/stats.c    | 87 ++++++++++++++++++++++++++++++++++++----------
> >>> fs/nfsd/stats.h    | 42 +++++++++++++++-------
> >>> fs/nfsd/vfs.c      |  4 +--
> >>> 8 files changed, 156 insertions(+), 58 deletions(-)
> >>>
> >>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> >>> index 7346acda9d76..080c5389b2e7 100644
> >>> --- a/fs/nfsd/netns.h
> >>> +++ b/fs/nfsd/netns.h
> >>> @@ -10,6 +10,7 @@
> >>>
> >>> #include <net/net_namespace.h>
> >>> #include <net/netns/generic.h>
> >>> +#include <linux/percpu_counter.h>
> >>>
> >>> /* Hash tables for nfs4_clientid state */
> >>> #define CLIENT_HASH_BITS                 4
> >>> @@ -149,20 +150,25 @@ struct nfsd_net {
> >>>
> >>>      /*
> >>>       * Stats and other tracking of on the duplicate reply cache.
> >>> -      * These fields and the "rc" fields in nfsdstats are modified
> >>> -      * with only the per-bucket cache lock, which isn't really safe
> >>> -      * and should be fixed if we want the statistics to be
> >>> -      * completely accurate.
> >>> +      * The longest_chain* fields are modified with only the per-bucket
> >>> +      * cache lock, which isn't really safe and should be fixed if we want
> >>> +      * these statistics to be completely accurate.
> >>>       */
> >>>
> >>>      /* total number of entries */
> >>>      atomic_t                 num_drc_entries;
> >>>
> >>> +     /* Reference to below counters as array for init/destroy */
> >>> +     struct percpu_counter    counters[0];
> >>
> >> This feels slightly too clever for its own good, but....  OK, I see
> >> there's a bunch of initializations to do in the nfsdstats case, and you
> >> don't want to open code all that (and its error handling).  I guess I
> >
> > Yeh, look at ceph_metric_init() and imagine what nfsdstats init
> > would look like.
> >
> >> don't have a better idea.  Is this a common pattern elsewhere?
> >>
> >
> > Sort of. Inspired by xfsstats and related macros (fs/xfs/xfs_stats.h).
> > I have tried several approaches and this one ended up being the
> > cleanest and smallest patch.
> >
> > The cleaner way would be an actual percpu_counter array and
> > convert all callers to use enum index to array like the dqstats counters
> > (include/linux/quota.h), but IMO current patch is enough.
>
> I'd prefer the "array with enum indices" approach. The current
> patch risks breaking C aliasing rules, IMHO -- with undefined
> consequences. I don't see a compelling reason we have to take
> that risk, however small it might be.
>
> At the very least, you could make the counters array and the
> set of counters into a union, but I'd prefer always accessing
> the underlying memory using the same high-level language
> constructs. That way, humans and compilers agree on what's
> going on here.
>

No problem. I just cannot resist a good shortcut when I see one ;-)
enum indices it shall be.

Thanks,
Amir.
