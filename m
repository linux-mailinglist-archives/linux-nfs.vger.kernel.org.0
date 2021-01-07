Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB892ECADE
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jan 2021 08:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbhAGHSf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jan 2021 02:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbhAGHSe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Jan 2021 02:18:34 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63062C0612F4
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jan 2021 23:17:54 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id q5so5789338ilc.10
        for <linux-nfs@vger.kernel.org>; Wed, 06 Jan 2021 23:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6fQ0Vt9UMe0nVugr25SHnGAr5WoJqU1gqQ8qFPjLOw=;
        b=snq4SHcJBc7V6jHphxqfFTvwxhGpzfbK2ivY5x/Q62sYRcRO0hag18Y1RMw6a46UkT
         cD3Py4Wd9A+fFveZngIIpKUsq6RCo22xR066ZHliyekt5Q9gA+YRb45MLp97JcJTvWc9
         p05dqTmqmlj/5HjXgE3w2R0RPDF7c0DZ7kSOJRUIalulzkHZLjSP04cuV3NzLUUt9tAU
         X8JYJnXYIs9nMpE4c21puortqNpSJIaKPiKAWFgnlkdpFvWh6L+klrfyXDig00GH3grr
         /Nk9gAl9TtVLFMgdd9w73I+dDHU2H9Z63KJ8YmU3+pW2eqy9oiH/9owPu0+XyktEzxuc
         iG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6fQ0Vt9UMe0nVugr25SHnGAr5WoJqU1gqQ8qFPjLOw=;
        b=lUKAAtuHQZjdAn9mAxRqokLdhbZ9B4kHOlr2ebkrUr9XVu76rcvoMv4WuLwCiILbVF
         Iu5f6lqdu6dIAMDM9xmp4r3SH2x6wPFDXKheSf+1iKjtPwjHKmc6ldZrt8PAhLJvE0hW
         9iIJkBTy/bGi5X8GMLAfC1WJlkPw0k5z2W3CTid86zm/jNzcKEUCEdhmmIZqWBPPTSH7
         a2dA9QtBqMLdhAWlsK2Gew+erHNidG4TOhU7GDwNEtK2kTRdOKXJuAjcuGQ6gX0/fccy
         5X/fQoTe92f2RyvdI0IKNDkMTP2G+JU4jMWroMsllGxssJ6uRWU9uTw8i+u9syncH2Az
         0nnQ==
X-Gm-Message-State: AOAM531dwLKr45ysvIEQCiEZv5AII4TBP7zT9FFj+hvdwwNY4GufAWdu
        jbyDRMeu+bYKbh93JVLPZfcB0U97XEk2Glre+iCpgzM9jjw=
X-Google-Smtp-Source: ABdhPJy1CKCGY8SdQGsA9jzDAgP4Wgis3Fkkh1N5q8mhgXNWLB/65E6TdU1TOodrQ5Do4PhBy86UnGJltZd8KtBBokI=
X-Received: by 2002:a92:d587:: with SMTP id a7mr3536007iln.250.1610003873831;
 Wed, 06 Jan 2021 23:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20210106075236.4184-1-amir73il@gmail.com> <20210106075236.4184-3-amir73il@gmail.com>
 <20210106205017.GG13116@fieldses.org>
In-Reply-To: <20210106205017.GG13116@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 7 Jan 2021 09:17:42 +0200
Message-ID: <CAOQ4uxgh=f7fQ6Zf6ry8tC-WXMEoZzTo50y+K56paLTyadV7yw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] nfsd: protect concurrent access to nfsd stats counters
To:     "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jan 6, 2021 at 10:50 PM J . Bruce Fields <bfields@fieldses.org> wrote:
>
> These three patches seem fine.  To bikeshed just a bit more:
>
> On Wed, Jan 06, 2021 at 09:52:35AM +0200, Amir Goldstein wrote:
> >       /* We found a matching entry which is either in progress or done. */
> > -     nfsdstats.rchits++;
> > +     nfsd_stats_rc_hits_inc();
>
> Maybe make that something like
>
>         nfsd_stats_inc(NFSD_STATS_RC_HITS);
>
> and then we could avoid boilerplate like the below?
>

It looks like boilerplate, but every helper is a bit different,
so we would have to introduce several variants like:

         nfsd_net_stats_inc(nn, NFSD_NET_PAYLOAD_MISSES);

Which is the way I started, but realized it opens a big hole for
human mistakes in the form of:

         nfsd_net_stats_inc(nn, NFSD_STATS_RC_HITS);
         nfsd_stats_inc(NFSD_NET_PAYLOAD_MISSES);

And we have no way to detect those errors at compile time
because enum types are not strict types.

Also, in the next patch, three more helpers become unique
as they are made into helpers to account for both global and per-export
stats (fh_stale, io_read, io_write).
Making those helpers generic would require aligning the start of global
stats enum values with the per-export enum values and that is a source
of more human errors.

See the end result of stats.h. All the helpers are unique and the only ones
that remain generic are nfsd_stats_rc_*.
Making those generic would also require checking the range of the index
value is in the NFSD_STATS_RC_* range.

I also tried a version with boilerplate defining macros, i.e.:

NFSD_STATS_FUNCS(rc_hits, RC_HITS)
NFSD_STATS_FUNCS(fh_stale, FH_STALE)
NFSD_STATS_FUNCS(io_read, IO_READ)

But when I realized in the end it can only serve the rc_* counters,
I dropped it.

Thoughts?

Thanks,
Amir.


> --b.
>
> > +static inline void nfsd_stats_rc_hits_inc(void)
> > +{
> > +     percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_HITS]);
> > +}
> > +
> > +static inline void nfsd_stats_rc_misses_inc(void)
> > +{
> > +     percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_MISSES]);
> > +}
> > +
> > +static inline void nfsd_stats_rc_nocache_inc(void)
> > +{
> > +     percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_RC_NOCACHE]);
> > +}
> > +
> > +static inline void nfsd_stats_fh_stale_inc(void)
> > +{
> > +     percpu_counter_inc(&nfsdstats.counter[NFSD_STATS_FH_STALE]);
> > +}
> > +
> > +static inline void nfsd_stats_io_read_add(s64 amount)
> > +{
> > +     percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_READ], amount);
> > +}
> > +
> > +static inline void nfsd_stats_io_write_add(s64 amount)
> > +{
> > +     percpu_counter_add(&nfsdstats.counter[NFSD_STATS_IO_WRITE], amount);
> > +}
> > +
> > +static inline void nfsd_stats_payload_misses_inc(struct nfsd_net *nn)
> > +{
> > +     percpu_counter_inc(&nn->counter[NFSD_NET_PAYLOAD_MISSES]);
> > +}
> > +
> > +static inline void nfsd_stats_drc_mem_usage_add(struct nfsd_net *nn, s64 amount)
> > +{
> > +     percpu_counter_add(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
> > +}
> > +
> > +static inline void nfsd_stats_drc_mem_usage_sub(struct nfsd_net *nn, s64 amount)
> > +{
> > +     percpu_counter_sub(&nn->counter[NFSD_NET_DRC_MEM_USAGE], amount);
> > +}
