Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F3230440
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 23:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfE3Vyn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 17:54:43 -0400
Received: from fieldses.org ([173.255.197.46]:41232 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfE3Vyk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 May 2019 17:54:40 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 4D5ED1E29; Thu, 30 May 2019 17:38:57 -0400 (EDT)
Date:   Thu, 30 May 2019 17:38:57 -0400
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/3] SUNRPC: Count ops completing with tk_status < 0
Message-ID: <20190530213857.GA24802@fieldses.org>
References: <20190523201351.12232-1-dwysocha@redhat.com>
 <20190523201351.12232-3-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523201351.12232-3-dwysocha@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 23, 2019 at 04:13:50PM -0400, Dave Wysochanski wrote:
> We often see various error conditions with NFS4.x that show up with
> a very high operation count all completing with tk_status < 0 in a
> short period of time.  Add a count to rpc_iostats to record on a
> per-op basis the ops that complete in this manner, which will
> enable lower overhead diagnostics.

Looks like a good idea to me.

It's too bad we can't distinguish the errors.  (E.g. ESTALE on a lookup
call is a lot more interesting than ENOENT.)  But understood that
maintaining (number of possible errors) * (number of possible ops)
counters is probably overkill, so just counting the number of errors
seems like a good start.

--b.

> 
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  include/linux/sunrpc/metrics.h | 7 ++++++-
>  net/sunrpc/stats.c             | 8 ++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sunrpc/metrics.h b/include/linux/sunrpc/metrics.h
> index 1b3751327575..0ee3f7052846 100644
> --- a/include/linux/sunrpc/metrics.h
> +++ b/include/linux/sunrpc/metrics.h
> @@ -30,7 +30,7 @@
>  #include <linux/ktime.h>
>  #include <linux/spinlock.h>
>  
> -#define RPC_IOSTATS_VERS	"1.0"
> +#define RPC_IOSTATS_VERS	"1.1"
>  
>  struct rpc_iostats {
>  	spinlock_t		om_lock;
> @@ -66,6 +66,11 @@ struct rpc_iostats {
>  	ktime_t			om_queue,	/* queued for xmit */
>  				om_rtt,		/* RPC RTT */
>  				om_execute;	/* RPC execution */
> +	/*
> +	 * The count of operations that complete with tk_status < 0.
> +	 * These statuses usually indicate error conditions.
> +	 */
> +	unsigned long           om_error_status;
>  } ____cacheline_aligned;
>  
>  struct rpc_task;
> diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
> index 8b2d3c58ffae..737414247ca7 100644
> --- a/net/sunrpc/stats.c
> +++ b/net/sunrpc/stats.c
> @@ -176,6 +176,8 @@ void rpc_count_iostats_metrics(const struct rpc_task *task,
>  
>  	execute = ktime_sub(now, task->tk_start);
>  	op_metrics->om_execute = ktime_add(op_metrics->om_execute, execute);
> +	if (task->tk_status < 0)
> +		op_metrics->om_error_status++;
>  
>  	spin_unlock(&op_metrics->om_lock);
>  
> @@ -218,13 +220,14 @@ static void _add_rpc_iostats(struct rpc_iostats *a, struct rpc_iostats *b)
>  	a->om_queue = ktime_add(a->om_queue, b->om_queue);
>  	a->om_rtt = ktime_add(a->om_rtt, b->om_rtt);
>  	a->om_execute = ktime_add(a->om_execute, b->om_execute);
> +	a->om_error_status += b->om_error_status;
>  }
>  
>  static void _print_rpc_iostats(struct seq_file *seq, struct rpc_iostats *stats,
>  			       int op, const struct rpc_procinfo *procs)
>  {
>  	_print_name(seq, op, procs);
> -	seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu %llu\n",
> +	seq_printf(seq, "%lu %lu %lu %llu %llu %llu %llu %llu %lu\n",
>  		   stats->om_ops,
>  		   stats->om_ntrans,
>  		   stats->om_timeouts,
> @@ -232,7 +235,8 @@ static void _print_rpc_iostats(struct seq_file *seq, struct rpc_iostats *stats,
>  		   stats->om_bytes_recv,
>  		   ktime_to_ms(stats->om_queue),
>  		   ktime_to_ms(stats->om_rtt),
> -		   ktime_to_ms(stats->om_execute));
> +		   ktime_to_ms(stats->om_execute),
> +		   stats->om_error_status);
>  }
>  
>  void rpc_clnt_show_stats(struct seq_file *seq, struct rpc_clnt *clnt)
> -- 
> 2.20.1
