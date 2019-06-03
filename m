Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49081338E1
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 21:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfFCTF5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 15:05:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32922 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFCTF5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jun 2019 15:05:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id 14so10808880qtf.0
        for <linux-nfs@vger.kernel.org>; Mon, 03 Jun 2019 12:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7WptPUlC3ibep377y8SkMrEPh68NAi6d+3/25NYBvE=;
        b=ISQKJQJ+Z7y0qsXWKtjWRkfd1h5uXOFcvZZQI/+Jeg8kzWZ5Jo63/sxCX3Q7ZqTjXR
         +AYz04cxu2bvNEj4Tejluz5Xg3tRfnMPVf0+8PwQhRKI7LARXhBVP3otwwsH4GbGK7DH
         W1p/oPad6YH1LrLXUGC6B9cS+bKFe/3eBYnvGsa2uAiawlJy4e9YpQUzmXkeoGOcCnb8
         u6qojiphgYLJU1BhEyVqLf6QSj7+VHmDklzo87svh1ecPzOqQUL9yefA8kgVtUteyAYo
         G/+/XJAgzUj8YNt8o/HbAGyOMNNUfVlMdPhX2jRhGqbBPL0wI9lggTrV86b0zqnFltC3
         qHWw==
X-Gm-Message-State: APjAAAUBHJhjCmVVai4GKHzBqOqjPGp8o/orUpLqt5YoQMlA8SvuhR/1
        ur+ruxfBZGDdIiNnDKtpUKFkU3/NTLc=
X-Google-Smtp-Source: APXvYqwniOVnPl+CxfC/ckvx2GtSu3b+9MLCHm7CpiyhlksVGAZx/fYTVveQB7htUW5Dac0CN2JbIQ==
X-Received: by 2002:a0c:b5c7:: with SMTP id o7mr23223705qvf.220.1559588755778;
        Mon, 03 Jun 2019 12:05:55 -0700 (PDT)
Received: from dhcp-12-212-173.gsslab.rdu.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id n10sm4135995qtp.81.2019.06.03.12.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:05:55 -0700 (PDT)
Message-ID: <1aa781ed6185ea61bed1efb7c8012dc543e3dc3f.camel@redhat.com>
Subject: Re: [PATCH 3/3] SUNRPC: Count ops completing with tk_status < 0
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 03 Jun 2019 15:05:54 -0400
In-Reply-To: <5CE8A68E-F5C2-4321-8F57-451F5E5AF789@oracle.com>
References: <20190523201351.12232-1-dwysocha@redhat.com>
         <20190523201351.12232-3-dwysocha@redhat.com>
         <20190530213857.GA24802@fieldses.org>
         <9B9F0C9B-C493-44F5-ABD1-6B2B4BAA2F08@oracle.com>
         <20190530223314.GA25368@fieldses.org>
         <CD3B0503-ABA0-4670-9A76-0B9DF0AE5B5C@oracle.com>
         <f7976bde9979e8b763c0009b523331ab5ce6b6ed.camel@redhat.com>
         <5CE8A68E-F5C2-4321-8F57-451F5E5AF789@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2019-06-03 at 14:56 -0400, Chuck Lever wrote:
> > On Jun 3, 2019, at 2:53 PM, Dave Wysochanski <dwysocha@redhat.com>
> > wrote:
> > 
> > On Fri, 2019-05-31 at 09:25 -0400, Chuck Lever wrote:
> > > > On May 30, 2019, at 6:33 PM, Bruce Fields <bfields@fieldses.org
> > > > >
> > > > wrote:
> > > > 
> > > > On Thu, May 30, 2019 at 06:19:54PM -0400, Chuck Lever wrote:
> > > > > 
> > > > > 
> > > > > > On May 30, 2019, at 5:38 PM, bfields@fieldses.org wrote:
> > > > > > 
> > > > > > On Thu, May 23, 2019 at 04:13:50PM -0400, Dave Wysochanski
> > > > > > wrote:
> > > > > > > We often see various error conditions with NFS4.x that
> > > > > > > show
> > > > > > > up with
> > > > > > > a very high operation count all completing with tk_status
> > > > > > > < 0
> > > > > > > in a
> > > > > > > short period of time.  Add a count to rpc_iostats to
> > > > > > > record
> > > > > > > on a
> > > > > > > per-op basis the ops that complete in this manner, which
> > > > > > > will
> > > > > > > enable lower overhead diagnostics.
> > > > > > 
> > > > > > Looks like a good idea to me.
> > > > > > 
> > > > > > It's too bad we can't distinguish the errors.  (E.g. ESTALE
> > > > > > on
> > > > > > a lookup
> > > > > > call is a lot more interesting than ENOENT.)  But
> > > > > > understood
> > > > > > that
> > > > > > maintaining (number of possible errors) * (number of
> > > > > > possible
> > > > > > ops)
> > > > > > counters is probably overkill, so just counting the number
> > > > > > of
> > > > > > errors
> > > > > > seems like a good start.
> > > > > 
> > > > > We now have trace points that can do that too.
> > > > 
> > > > You mean, that can report every error (and its value)?
> > > 
> > > Yes, the nfs_xdr_status trace point reports the error by value
> > > and
> > > symbolic name.
> > > 
> > 
> > The tracepoint is very useful I agree.  I don't think it will show:
> > a) the mount
> > b) the opcode
> > 
> > Or am I mistaken and there's a way to get those with a filter or
> > another tracepoint?
> 
> The opcode can be exposed by another trace point, but the link
> between
> the two trace points is tenuous and could be improved.
> 

I think the number is there but it's not decoded!  This was for a WRITE
completing with BAD_STATEID - very nice:

   kworker/u16:0-31130 [006] .... 949028.602298: nfs4_xdr_status: operation 38: nfs status -10025 (BAD_STATEID)



> I don't believe any of the NFS trace points expose the mount. My
> testing
> is largely on a single mount so my imagination stopped there.
> 

Ok thanks for the confirmation.


> 
> > > > I assume having these statistics in mountstats is still useful,
> > > > though.
> > > > 
> > > > --b.
> > > > 
> > > > > 
> > > > > 
> > > > > > --b.
> > > > > > 
> > > > > > > 
> > > > > > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > > > > ---
> > > > > > > include/linux/sunrpc/metrics.h | 7 ++++++-
> > > > > > > net/sunrpc/stats.c             | 8 ++++++--
> > > > > > > 2 files changed, 12 insertions(+), 3 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/include/linux/sunrpc/metrics.h
> > > > > > > b/include/linux/sunrpc/metrics.h
> > > > > > > index 1b3751327575..0ee3f7052846 100644
> > > > > > > --- a/include/linux/sunrpc/metrics.h
> > > > > > > +++ b/include/linux/sunrpc/metrics.h
> > > > > > > @@ -30,7 +30,7 @@
> > > > > > > #include <linux/ktime.h>
> > > > > > > #include <linux/spinlock.h>
> > > > > > > 
> > > > > > > -#define RPC_IOSTATS_VERS	"1.0"
> > > > > > > +#define RPC_IOSTATS_VERS	"1.1"
> > > > > > > 
> > > > > > > struct rpc_iostats {
> > > > > > > 	spinlock_t		om_lock;
> > > > > > > @@ -66,6 +66,11 @@ struct rpc_iostats {
> > > > > > > 	ktime_t			om_queue,	/* queued
> > > > > > > for
> > > > > > > xmit */
> > > > > > > 				om_rtt,		/* RPC
> > > > > > > RTT */
> > > > > > > 				om_execute;	/* RPC
> > > > > > > execution */
> > > > > > > +	/*
> > > > > > > +	 * The count of operations that complete with tk_status
> > > > > > > < 0.
> > > > > > > +	 * These statuses usually indicate error conditions.
> > > > > > > +	 */
> > > > > > > +	unsigned long           om_error_status;
> > > > > > > } ____cacheline_aligned;
> > > > > > > 
> > > > > > > struct rpc_task;
> > > > > > > diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
> > > > > > > index 8b2d3c58ffae..737414247ca7 100644
> > > > > > > --- a/net/sunrpc/stats.c
> > > > > > > +++ b/net/sunrpc/stats.c
> > > > > > > @@ -176,6 +176,8 @@ void rpc_count_iostats_metrics(const
> > > > > > > struct rpc_task *task,
> > > > > > > 
> > > > > > > 	execute = ktime_sub(now, task->tk_start);
> > > > > > > 	op_metrics->om_execute = ktime_add(op_metrics-
> > > > > > > > om_execute, execute);
> > > > > > > 
> > > > > > > +	if (task->tk_status < 0)
> > > > > > > +		op_metrics->om_error_status++;
> > > > > > > 
> > > > > > > 	spin_unlock(&op_metrics->om_lock);
> > > > > > > 
> > > > > > > @@ -218,13 +220,14 @@ static void _add_rpc_iostats(struct
> > > > > > > rpc_iostats *a, struct rpc_iostats *b)
> > > > > > > 	a->om_queue = ktime_add(a->om_queue, b->om_queue);
> > > > > > > 	a->om_rtt = ktime_add(a->om_rtt, b->om_rtt);
> > > > > > > 	a->om_execute = ktime_add(a->om_execute, b-
> > > > > > > > om_execute);
> > > > > > > 
> > > > > > > +	a->om_error_status += b->om_error_status;
> > > > > > > }
> > > > > > > 
> > > > > > > static void _print_rpc_iostats(struct seq_file *seq,
> > > > > > > struct
> > > > > > > rpc_iostats *stats,
> > > > > > > 			       int op, const struct
> > > > > > > rpc_procinfo *procs)
> > > > > > > {
> > > > > > > 	_print_name(seq, op, procs);
> > > > > > > -	seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu
> > > > > > > %llu\n",
> > > > > > > +	seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu %llu
> > > > > > > %lu\n",
> > > > > > > 		   stats->om_ops,
> > > > > > > 		   stats->om_ntrans,
> > > > > > > 		   stats->om_timeouts,
> > > > > > > @@ -232,7 +235,8 @@ static void _print_rpc_iostats(struct
> > > > > > > seq_file *seq, struct rpc_iostats *stats,
> > > > > > > 		   stats->om_bytes_recv,
> > > > > > > 		   ktime_to_ms(stats->om_queue),
> > > > > > > 		   ktime_to_ms(stats->om_rtt),
> > > > > > > -		   ktime_to_ms(stats->om_execute));
> > > > > > > +		   ktime_to_ms(stats->om_execute),
> > > > > > > +		   stats->om_error_status);
> > > > > > > }
> > > > > > > 
> > > > > > > void rpc_clnt_show_stats(struct seq_file *seq, struct
> > > > > > > rpc_clnt *clnt)
> > > > > > > -- 
> > > > > > > 2.20.1
> > > > > 
> > > > > --
> > > > > Chuck Lever
> > > 
> > > --
> > > Chuck Lever
> 
> --
> Chuck Lever
> 
> 
> 


