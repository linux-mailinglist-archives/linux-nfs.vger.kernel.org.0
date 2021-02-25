Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82C325278
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Feb 2021 16:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhBYPeA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Feb 2021 10:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBYPd7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Feb 2021 10:33:59 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADFEC061574
        for <linux-nfs@vger.kernel.org>; Thu, 25 Feb 2021 07:33:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j9so7458825edp.1
        for <linux-nfs@vger.kernel.org>; Thu, 25 Feb 2021 07:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBU/OJs1oazuHzev0LQSaEiiFBAjfJ/gHXfgQKJFjvg=;
        b=pCatAZSpWpuoGNviYV0og5hFGXpyhH3tv13di+ZpV5LOOtTIw9s8b4jRyQYYU9U7/H
         ZZJCIqYBN3MM5SUerj3Jgw2gYMRAxHLSg+OcX8WX6ejJqOovHOtunW96mNTHmELQPwK1
         8aKLLcStu3iI6kzNd1fj+36wekol8W4OtSTYiY/4n6FRbx16p9VS0z90+E9sMNHsw9co
         ZUMfaHhRz6FI517aeMTzTncsZcdwQTLIvX5oH2McyUgcNqFR+8MWnihxN6aeCWpmSC3V
         rQnSh+6YItuAhyaq5B8gi9mYmtZsMcpL4m8pKeSM4dLYMlpbtCfU5G6dv6ptx7uzjJWN
         1Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBU/OJs1oazuHzev0LQSaEiiFBAjfJ/gHXfgQKJFjvg=;
        b=JoYPlBvxT68hYBL48icxicvY6/SkRVSu2V0gKg0ImaqTgSIjQ/A2IV9nAHBWdkKx/W
         dFnPHH0l6Jv1OUSSyU/dZVq+qhPRe7hj0wfGjz2VWPcRmxKvXYdMnVc2DJcnBv0N923Z
         ELrxrtVtQHfbJHTAPuF02w8aFnjOJJHn1SPCEQ1jXRebWR4CQhg9xZLR4mpuM3n/GWyn
         WHpUu2hjxo+rF0EzbpZEczl3VsMd+eMHMZysWcOelRIgCWxA8x+rieW9NYP49IqORK4k
         ViDjXZBs0FIFGM7MWLIO6om7ZbrOsJNeK1oFMyZBuzaA/koN8nB/hI4aiX0NPdC5UZhT
         gLuA==
X-Gm-Message-State: AOAM530JJqnmas31vz8D/bfoHvJ0olVSoY3KzlZyHJcvTp2OI/+/nQRP
        y0TAvOVxP8yxknGecvksn/aJU88bJy3rcQQfdFclhgUD
X-Google-Smtp-Source: ABdhPJxdZB3upeatZzBuwom4uRxwnO+k/aDWz0spR6sK+xItLYo3VSxgCYbTl/WE+d4XBBQtcCfx9inackPBNyeqQrE=
X-Received: by 2002:aa7:c887:: with SMTP id p7mr3501966eds.28.1614267195959;
 Thu, 25 Feb 2021 07:33:15 -0800 (PST)
MIME-Version: 1.0
References: <20210224183950.GB11591@fieldses.org> <20210224193135.GC11591@fieldses.org>
 <59A5F476-EE0C-454F-8365-3F16505D9D45@oracle.com> <20210224223349.GB25689@fieldses.org>
 <CDFF4F84-1A0C-4E4C-A18B-AC39F715E6D8@oracle.com>
In-Reply-To: <CDFF4F84-1A0C-4E4C-A18B-AC39F715E6D8@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 25 Feb 2021 10:33:04 -0500
Message-ID: <CAN-5tyFLLLfMwZVFrnQaCnR36Rfq_hPsmLEOLG2Qtrpc+pT7fA@mail.gmail.com>
Subject: Re: [PATCH] nfsd: don't abort copies early
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Feb 25, 2021 at 10:30 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Feb 24, 2021, at 5:33 PM, Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Wed, Feb 24, 2021 at 07:34:10PM +0000, Chuck Lever wrote:
> >>
> >>
> >>> On Feb 24, 2021, at 2:31 PM, J. Bruce Fields <bfields@fieldses.org> wrote:
> >>>
> >>> I confess I always have to stare at these comparisons for a minute to
> >>> figure out which way they should go.  And the logic in each of these
> >>> loops is a little repetitive.
> >>>
> >>> Would it be worth creating a little state_expired() helper to work out
> >>> the comparison and the new timeout?
> >>
> >> That's better, but aren't there already operators on time64_t data objects
> >> that can be used for this?
> >
> > No idea.
>
> I was thinking of jiffies, I guess. time_before() and time_after().

Just my 2c. My initial original patches used time_after(). It was
specifically changed by somebody later to use the current api.

> Checking the definition of time64_t, from include/linux/time64.h:
>
> typedef __s64 time64_t;
>
> Signed, hrm. And no comparison helpers.
>
> I might be a little concerned about wrapping time values. But any
> concerns can be addressed in the new common helper state_expired(),
> possibly as a subsequent patch.
>
> If you feel it's ready, can you send me the below clean-up as an
> official patch with description and SoB?
>
>
> > --b.
> >
> >>
> >>
> >>> --b.
> >>>
> >>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >>> index 61552e89bd89..00fb3603c29e 100644
> >>> --- a/fs/nfsd/nfs4state.c
> >>> +++ b/fs/nfsd/nfs4state.c
> >>> @@ -5363,6 +5363,22 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
> >>>     return true;
> >>> }
> >>>
> >>> +struct laundry_time {
> >>> +   time64_t cutoff;
> >>> +   time64_t new_timeo;
> >>> +};
> >>> +
> >>> +bool state_expired(struct laundry_time *lt, time64_t last_refresh)
> >>> +{
> >>> +   time64_t time_remaining;
> >>> +
> >>> +   if (last_refresh > lt->cutoff)
> >>> +           return true;
> >>> +   time_remaining = lt->cutoff - last_refresh;
> >>> +   lt->new_timeo = min(lt->new_timeo, time_remaining);
> >>> +   return false;
> >>> +}
> >>> +
> >>> static time64_t
> >>> nfs4_laundromat(struct nfsd_net *nn)
> >>> {
> >>> @@ -5372,14 +5388,16 @@ nfs4_laundromat(struct nfsd_net *nn)
> >>>     struct nfs4_ol_stateid *stp;
> >>>     struct nfsd4_blocked_lock *nbl;
> >>>     struct list_head *pos, *next, reaplist;
> >>> -   time64_t cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease;
> >>> -   time64_t t, new_timeo = nn->nfsd4_lease;
> >>> +   struct laundry_time lt = {
> >>> +           .cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease,
> >>> +           .new_timeo = nn->nfsd4_lease
> >>> +   };
> >>>     struct nfs4_cpntf_state *cps;
> >>>     copy_stateid_t *cps_t;
> >>>     int i;
> >>>
> >>>     if (clients_still_reclaiming(nn)) {
> >>> -           new_timeo = 0;
> >>> +           lt.new_timeo = 0;
> >>>             goto out;
> >>>     }
> >>>     nfsd4_end_grace(nn);
> >>> @@ -5389,7 +5407,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> >>>     idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
> >>>             cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
> >>>             if (cps->cp_stateid.sc_type == NFS4_COPYNOTIFY_STID &&
> >>> -                           cps->cpntf_time < cutoff)
> >>> +                           state_expired(&lt, cps->cpntf_time))
> >>>                     _free_cpntf_state_locked(nn, cps);
> >>>     }
> >>>     spin_unlock(&nn->s2s_cp_lock);
> >>> @@ -5397,11 +5415,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> >>>     spin_lock(&nn->client_lock);
> >>>     list_for_each_safe(pos, next, &nn->client_lru) {
> >>>             clp = list_entry(pos, struct nfs4_client, cl_lru);
> >>> -           if (clp->cl_time > cutoff) {
> >>> -                   t = clp->cl_time - cutoff;
> >>> -                   new_timeo = min(new_timeo, t);
> >>> +           if (!state_expired(&lt, clp->cl_time))
> >>>                     break;
> >>> -           }
> >>>             if (mark_client_expired_locked(clp)) {
> >>>                     trace_nfsd_clid_expired(&clp->cl_clientid);
> >>>                     continue;
> >>> @@ -5418,11 +5433,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> >>>     spin_lock(&state_lock);
> >>>     list_for_each_safe(pos, next, &nn->del_recall_lru) {
> >>>             dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> >>> -           if (dp->dl_time > cutoff) {
> >>> -                   t = dp->dl_time - cutoff;
> >>> -                   new_timeo = min(new_timeo, t);
> >>> +           if (!state_expired(&lt, clp->cl_time))
> >>>                     break;
> >>> -           }
> >>>             WARN_ON(!unhash_delegation_locked(dp));
> >>>             list_add(&dp->dl_recall_lru, &reaplist);
> >>>     }
> >>> @@ -5438,11 +5450,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> >>>     while (!list_empty(&nn->close_lru)) {
> >>>             oo = list_first_entry(&nn->close_lru, struct nfs4_openowner,
> >>>                                     oo_close_lru);
> >>> -           if (oo->oo_time > cutoff) {
> >>> -                   t = oo->oo_time - cutoff;
> >>> -                   new_timeo = min(new_timeo, t);
> >>> +           if (!state_expired(&lt, oo->oo_time))
> >>>                     break;
> >>> -           }
> >>>             list_del_init(&oo->oo_close_lru);
> >>>             stp = oo->oo_last_closed_stid;
> >>>             oo->oo_last_closed_stid = NULL;
> >>> @@ -5468,11 +5477,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> >>>     while (!list_empty(&nn->blocked_locks_lru)) {
> >>>             nbl = list_first_entry(&nn->blocked_locks_lru,
> >>>                                     struct nfsd4_blocked_lock, nbl_lru);
> >>> -           if (nbl->nbl_time > cutoff) {
> >>> -                   t = nbl->nbl_time - cutoff;
> >>> -                   new_timeo = min(new_timeo, t);
> >>> +           if (!state_expired(&lt, oo->oo_time))
> >>>                     break;
> >>> -           }
> >>>             list_move(&nbl->nbl_lru, &reaplist);
> >>>             list_del_init(&nbl->nbl_list);
> >>>     }
> >>> @@ -5485,8 +5491,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> >>>             free_blocked_lock(nbl);
> >>>     }
> >>> out:
> >>> -   new_timeo = max_t(time64_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
> >>> -   return new_timeo;
> >>> +   return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
> >>> }
> >>>
> >>> static struct workqueue_struct *laundry_wq;
> >>
> >> --
> >> Chuck Lever
> >>
> >>
>
> --
> Chuck Lever
>
>
>
