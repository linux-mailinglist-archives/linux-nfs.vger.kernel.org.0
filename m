Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D8B3389B
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 20:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfFCSx5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 14:53:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46058 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfFCSx5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jun 2019 14:53:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id s22so1119419qkj.12
        for <linux-nfs@vger.kernel.org>; Mon, 03 Jun 2019 11:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VaEotB+Qqa8kg/VAEVw3vNQR5IbgQfvY3B1vBa4AR48=;
        b=Bx+AKJVMMfPRuDBhSCKOMVNqdITamba49yXLxC4jzDVr4a8T7yNzDbIejAjsHGWv8/
         fp1XOTGdLmRdUeJESZbPJZa2JC0QrC1s2hFfq7l7DFhz79zsvqP5Hdg/ciXEY9airq7q
         XHkQP6XGnBK4Am9Kv5EW0mivWw71kIWS96TbNnTJCrNVuLJ5BIwXWz8mpF0P9Buh6/5t
         ZoRVfE+WiClVt4pr3GUaJuDdAmM5MAHAUQbvtRSDijCzK1batwTxoTsEhoW8IFwhbbLk
         BWUrXTPfxjGsDLO9bb1LMo5AGmsOOczLLYeNBKIJpJQcv6w5qW9g1TGnyTwUhKRM4iED
         0bEA==
X-Gm-Message-State: APjAAAUzWHlznDPn78OtibzgRdaYRRoQC03OHOtUUz06Tpum843NAxLp
        GMm0GIDB//C9BasalR3oZwt6hpRboss=
X-Google-Smtp-Source: APXvYqy9rSyQ5lks4vb7lik1sk8v0j1bkbAaBnW4pUQ8XrpzjC1N3ncQDdKrRKlsWQNmepXX2ZBpDQ==
X-Received: by 2002:a37:ef14:: with SMTP id j20mr23337636qkk.162.1559588036087;
        Mon, 03 Jun 2019 11:53:56 -0700 (PDT)
Received: from dhcp-12-212-173.gsslab.rdu.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id p40sm11233495qte.93.2019.06.03.11.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:53:55 -0700 (PDT)
Message-ID: <f7976bde9979e8b763c0009b523331ab5ce6b6ed.camel@redhat.com>
Subject: Re: [PATCH 3/3] SUNRPC: Count ops completing with tk_status < 0
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 03 Jun 2019 14:53:54 -0400
In-Reply-To: <CD3B0503-ABA0-4670-9A76-0B9DF0AE5B5C@oracle.com>
References: <20190523201351.12232-1-dwysocha@redhat.com>
         <20190523201351.12232-3-dwysocha@redhat.com>
         <20190530213857.GA24802@fieldses.org>
         <9B9F0C9B-C493-44F5-ABD1-6B2B4BAA2F08@oracle.com>
         <20190530223314.GA25368@fieldses.org>
         <CD3B0503-ABA0-4670-9A76-0B9DF0AE5B5C@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2019-05-31 at 09:25 -0400, Chuck Lever wrote:
> > On May 30, 2019, at 6:33 PM, Bruce Fields <bfields@fieldses.org>
> > wrote:
> > 
> > On Thu, May 30, 2019 at 06:19:54PM -0400, Chuck Lever wrote:
> > > 
> > > 
> > > > On May 30, 2019, at 5:38 PM, bfields@fieldses.org wrote:
> > > > 
> > > > On Thu, May 23, 2019 at 04:13:50PM -0400, Dave Wysochanski
> > > > wrote:
> > > > > We often see various error conditions with NFS4.x that show
> > > > > up with
> > > > > a very high operation count all completing with tk_status < 0
> > > > > in a
> > > > > short period of time.  Add a count to rpc_iostats to record
> > > > > on a
> > > > > per-op basis the ops that complete in this manner, which will
> > > > > enable lower overhead diagnostics.
> > > > 
> > > > Looks like a good idea to me.
> > > > 
> > > > It's too bad we can't distinguish the errors.  (E.g. ESTALE on
> > > > a lookup
> > > > call is a lot more interesting than ENOENT.)  But understood
> > > > that
> > > > maintaining (number of possible errors) * (number of possible
> > > > ops)
> > > > counters is probably overkill, so just counting the number of
> > > > errors
> > > > seems like a good start.
> > > 
> > > We now have trace points that can do that too.
> > 
> > You mean, that can report every error (and its value)?
> 
> Yes, the nfs_xdr_status trace point reports the error by value and
> symbolic name.
> 

The tracepoint is very useful I agree.  I don't think it will show:
a) the mount
b) the opcode

Or am I mistaken and there's a way to get those with a filter or
another tracepoint?


> 
> > I assume having these statistics in mountstats is still useful,
> > though.
> > 
> > --b.
> > 
> > > 
> > > 
> > > > --b.
> > > > 
> > > > > 
> > > > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > > > ---
> > > > > include/linux/sunrpc/metrics.h | 7 ++++++-
> > > > > net/sunrpc/stats.c             | 8 ++++++--
> > > > > 2 files changed, 12 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/include/linux/sunrpc/metrics.h
> > > > > b/include/linux/sunrpc/metrics.h
> > > > > index 1b3751327575..0ee3f7052846 100644
> > > > > --- a/include/linux/sunrpc/metrics.h
> > > > > +++ b/include/linux/sunrpc/metrics.h
> > > > > @@ -30,7 +30,7 @@
> > > > > #include <linux/ktime.h>
> > > > > #include <linux/spinlock.h>
> > > > > 
> > > > > -#define RPC_IOSTATS_VERS	"1.0"
> > > > > +#define RPC_IOSTATS_VERS	"1.1"
> > > > > 
> > > > > struct rpc_iostats {
> > > > > 	spinlock_t		om_lock;
> > > > > @@ -66,6 +66,11 @@ struct rpc_iostats {
> > > > > 	ktime_t			om_queue,	/* queued for
> > > > > xmit */
> > > > > 				om_rtt,		/* RPC RTT */
> > > > > 				om_execute;	/* RPC
> > > > > execution */
> > > > > +	/*
> > > > > +	 * The count of operations that complete with tk_status
> > > > > < 0.
> > > > > +	 * These statuses usually indicate error conditions.
> > > > > +	 */
> > > > > +	unsigned long           om_error_status;
> > > > > } ____cacheline_aligned;
> > > > > 
> > > > > struct rpc_task;
> > > > > diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
> > > > > index 8b2d3c58ffae..737414247ca7 100644
> > > > > --- a/net/sunrpc/stats.c
> > > > > +++ b/net/sunrpc/stats.c
> > > > > @@ -176,6 +176,8 @@ void rpc_count_iostats_metrics(const
> > > > > struct rpc_task *task,
> > > > > 
> > > > > 	execute = ktime_sub(now, task->tk_start);
> > > > > 	op_metrics->om_execute = ktime_add(op_metrics-
> > > > > >om_execute, execute);
> > > > > +	if (task->tk_status < 0)
> > > > > +		op_metrics->om_error_status++;
> > > > > 
> > > > > 	spin_unlock(&op_metrics->om_lock);
> > > > > 
> > > > > @@ -218,13 +220,14 @@ static void _add_rpc_iostats(struct
> > > > > rpc_iostats *a, struct rpc_iostats *b)
> > > > > 	a->om_queue = ktime_add(a->om_queue, b->om_queue);
> > > > > 	a->om_rtt = ktime_add(a->om_rtt, b->om_rtt);
> > > > > 	a->om_execute = ktime_add(a->om_execute, b-
> > > > > >om_execute);
> > > > > +	a->om_error_status += b->om_error_status;
> > > > > }
> > > > > 
> > > > > static void _print_rpc_iostats(struct seq_file *seq, struct
> > > > > rpc_iostats *stats,
> > > > > 			       int op, const struct
> > > > > rpc_procinfo *procs)
> > > > > {
> > > > > 	_print_name(seq, op, procs);
> > > > > -	seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu
> > > > > %llu\n",
> > > > > +	seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu %llu
> > > > > %lu\n",
> > > > > 		   stats->om_ops,
> > > > > 		   stats->om_ntrans,
> > > > > 		   stats->om_timeouts,
> > > > > @@ -232,7 +235,8 @@ static void _print_rpc_iostats(struct
> > > > > seq_file *seq, struct rpc_iostats *stats,
> > > > > 		   stats->om_bytes_recv,
> > > > > 		   ktime_to_ms(stats->om_queue),
> > > > > 		   ktime_to_ms(stats->om_rtt),
> > > > > -		   ktime_to_ms(stats->om_execute));
> > > > > +		   ktime_to_ms(stats->om_execute),
> > > > > +		   stats->om_error_status);
> > > > > }
> > > > > 
> > > > > void rpc_clnt_show_stats(struct seq_file *seq, struct
> > > > > rpc_clnt *clnt)
> > > > > -- 
> > > > > 2.20.1
> > > 
> > > --
> > > Chuck Lever
> 
> --
> Chuck Lever
> 
> 
> 


