Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02EFF305B5
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2019 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfEaARl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 20:17:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46930 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfEaARl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 May 2019 20:17:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id z19so9270732qtz.13
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2019 17:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7Oh9IsKtFM5/C+q9jEZm7clejiE8TcaQezx9CsJEi0=;
        b=GllCbKegiEdUjlD+Pb33JPmRboy8DX+OZ1yZrKfUZSsWRMVvGaEQZ2TiLV4oQ8KgRe
         Yq9M8Btrld8/w49kM7UGenyyxnDB+jV6+DkKc51gTlWugsQCqh8cSvTatytcxCliQ3J/
         acRNXzfmgxNuzzLF/fQ4EzvUNxMbdq5kGFoZXYvrqclAbyKzoJZXuIzPK4W27yByCRWC
         CDfZXT86h1hmc5bLMdzGCeEXdmleKBqooy2NAeVQ6TF44tzC/rBDXMda3EgzHNHKMXTE
         1L0HQaQtpQ2TBr7CLc9/voIZTtsVE0HWlnzGDSH3iWuBTypMQkwb/nFkvKE0QMKNrNd9
         qNmA==
X-Gm-Message-State: APjAAAVxQ5APWtUJEYqx0NkQ71jsqCUmtV+emnpOsCwzRxH8ervOKb5M
        n0iYIpn23Nl7YoKiIdrHgHeVmGAnFCPuPMcOxchHQA==
X-Google-Smtp-Source: APXvYqw+/gOcQcduVJSeip9H+WsBzmfKFrvNJb9XX7Zq/gmS1onGy4i/zGbYsdJwTRrvja/TJRwpwOOumwiBPV+Scd4=
X-Received: by 2002:aed:3b0c:: with SMTP id p12mr6332157qte.283.1559261860092;
 Thu, 30 May 2019 17:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190523201351.12232-1-dwysocha@redhat.com> <20190523201351.12232-3-dwysocha@redhat.com>
 <20190530213857.GA24802@fieldses.org>
In-Reply-To: <20190530213857.GA24802@fieldses.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 30 May 2019 20:17:03 -0400
Message-ID: <CALF+zOk7Hmc3kZRwqtDsmA4kov65Afm8JvqCs7DU7_YSLXfCRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] SUNRPC: Count ops completing with tk_status < 0
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 30, 2019 at 5:39 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Thu, May 23, 2019 at 04:13:50PM -0400, Dave Wysochanski wrote:
> > We often see various error conditions with NFS4.x that show up with
> > a very high operation count all completing with tk_status < 0 in a
> > short period of time.  Add a count to rpc_iostats to record on a
> > per-op basis the ops that complete in this manner, which will
> > enable lower overhead diagnostics.
>
> Looks like a good idea to me.
>
> It's too bad we can't distinguish the errors.  (E.g. ESTALE on a lookup
> call is a lot more interesting than ENOENT.)  But understood that
> maintaining (number of possible errors) * (number of possible ops)
> counters is probably overkill, so just counting the number of errors
> seems like a good start.
>
> --b.
>

I did consider a more elaborate approach, where each code would be
counted.  Most likely that would need to go into debugfs.  I didn't
pursue that but may look into it in the future along with other work.

I do think the < 0 status counts have value even if we do not know the
specific code, they are very low overhead, and always there if added
to mountstats.  I was envisioning using this along with something like
a periodic capture of mountstats possibly using PCP and then using
some statistics as a "NFS health" measure for a specific mount point.
There are already some "NFS health" metrics that may be calculated
with existing mountstats (for example if you're clever you can spot
certain NFS4 protocol loops), but the error counts would make it much
easier and reliable.


> >
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> >  include/linux/sunrpc/metrics.h | 7 ++++++-
> >  net/sunrpc/stats.c             | 8 ++++++--
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/sunrpc/metrics.h b/include/linux/sunrpc/metrics.h
> > index 1b3751327575..0ee3f7052846 100644
> > --- a/include/linux/sunrpc/metrics.h
> > +++ b/include/linux/sunrpc/metrics.h
> > @@ -30,7 +30,7 @@
> >  #include <linux/ktime.h>
> >  #include <linux/spinlock.h>
> >
> > -#define RPC_IOSTATS_VERS     "1.0"
> > +#define RPC_IOSTATS_VERS     "1.1"
> >
> >  struct rpc_iostats {
> >       spinlock_t              om_lock;
> > @@ -66,6 +66,11 @@ struct rpc_iostats {
> >       ktime_t                 om_queue,       /* queued for xmit */
> >                               om_rtt,         /* RPC RTT */
> >                               om_execute;     /* RPC execution */
> > +     /*
> > +      * The count of operations that complete with tk_status < 0.
> > +      * These statuses usually indicate error conditions.
> > +      */
> > +     unsigned long           om_error_status;
> >  } ____cacheline_aligned;
> >
> >  struct rpc_task;
> > diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
> > index 8b2d3c58ffae..737414247ca7 100644
> > --- a/net/sunrpc/stats.c
> > +++ b/net/sunrpc/stats.c
> > @@ -176,6 +176,8 @@ void rpc_count_iostats_metrics(const struct rpc_task *task,
> >
> >       execute = ktime_sub(now, task->tk_start);
> >       op_metrics->om_execute = ktime_add(op_metrics->om_execute, execute);
> > +     if (task->tk_status < 0)
> > +             op_metrics->om_error_status++;
> >
> >       spin_unlock(&op_metrics->om_lock);
> >
> > @@ -218,13 +220,14 @@ static void _add_rpc_iostats(struct rpc_iostats *a, struct rpc_iostats *b)
> >       a->om_queue = ktime_add(a->om_queue, b->om_queue);
> >       a->om_rtt = ktime_add(a->om_rtt, b->om_rtt);
> >       a->om_execute = ktime_add(a->om_execute, b->om_execute);
> > +     a->om_error_status += b->om_error_status;
> >  }
> >
> >  static void _print_rpc_iostats(struct seq_file *seq, struct rpc_iostats *stats,
> >                              int op, const struct rpc_procinfo *procs)
> >  {
> >       _print_name(seq, op, procs);
> > -     seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu %llu\n",
> > +     seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu %llu %lu\n",
> >                  stats->om_ops,
> >                  stats->om_ntrans,
> >                  stats->om_timeouts,
> > @@ -232,7 +235,8 @@ static void _print_rpc_iostats(struct seq_file *seq, struct rpc_iostats *stats,
> >                  stats->om_bytes_recv,
> >                  ktime_to_ms(stats->om_queue),
> >                  ktime_to_ms(stats->om_rtt),
> > -                ktime_to_ms(stats->om_execute));
> > +                ktime_to_ms(stats->om_execute),
> > +                stats->om_error_status);
> >  }
> >
> >  void rpc_clnt_show_stats(struct seq_file *seq, struct rpc_clnt *clnt)
> > --
> > 2.20.1



-- 
Dave Wysochanski
Principal Software Maintenance Engineer
T: 919-754-4024
