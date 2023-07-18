Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CE4757DCD
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 15:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjGRNiT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 09:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjGRNiD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 09:38:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC18E2
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 06:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 233EC61597
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 13:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA87C433C8;
        Tue, 18 Jul 2023 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689687480;
        bh=KBvbmw1WWHe/arraW2JlMLNxjTVfSZWE1okbrwU7YhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QsnaDvL/CQxz3n1WlX5ziIUVJ3cU9bDCf1Ev21bOESI+6X5yYGNgGJKAMR0dH/PUT
         qEH7eUo2K8mp9R+dlrAiRxxmBFM+2+Moq+xXzggiTQgXPWKu6MrpFa5cmJ5sX5zFgm
         2Gfma2bX+4IaPN7n8BHZ8QwukXRP5WUURfwExRfzVp4kyiwhUAaAAEc6O1gdkSI4sV
         05P8HbAIaM11Se5n1LgdyPqRxTZh8T08wpEPh1sCuX+S9A935LGMvGuKE5T5INE1d4
         7T3Kycu1bOI85joaEWcU4FWx/c+j1t/WNBnZgSdyZ3Y80RkPgYWou2GXp6+aH9M1UY
         fk6r1SrnmoR6A==
Date:   Tue, 18 Jul 2023 09:37:58 -0400
From:   Chuck Lever <cel@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/14] SUNRPC: change various server-side #defines to enum
Message-ID: <ZLaVtpLf1k2Ig5Kz@bazille.1015granger.net>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
 <168966228863.11075.8173252015139876869.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168966228863.11075.8173252015139876869.stgit@noble.brown>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
> When a sequence of numbers are needed for internal-use only, an enum is
> typically best.  The sequence will inevitably need to be changed one
> day, and having an enum means the developer doesn't need to think about
> renumbering after insertion or deletion.  The patch will be easier to
> review.

Last sentence needs to define the antecedant of "The patch".


> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/sunrpc/cache.h    |   11 +++++++----
>  include/linux/sunrpc/svc.h      |   34 ++++++++++++++++++++--------------
>  include/linux/sunrpc/svc_xprt.h |   39 +++++++++++++++++++++------------------
>  include/linux/sunrpc/svcauth.h  |   29 ++++++++++++++++-------------
>  include/linux/sunrpc/xprtsock.h |   25 +++++++++++++------------
>  5 files changed, 77 insertions(+), 61 deletions(-)
> 
> diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
> index 518bd28f5ab8..3cc4f4f0c764 100644
> --- a/include/linux/sunrpc/cache.h
> +++ b/include/linux/sunrpc/cache.h
> @@ -56,10 +56,13 @@ struct cache_head {
>  	struct kref	ref;
>  	unsigned long	flags;
>  };
> -#define	CACHE_VALID	0	/* Entry contains valid data */
> -#define	CACHE_NEGATIVE	1	/* Negative entry - there is no match for the key */
> -#define	CACHE_PENDING	2	/* An upcall has been sent but no reply received yet*/
> -#define	CACHE_CLEANED	3	/* Entry has been cleaned from cache */
> +/* cache_head.flags */
> +enum {
> +	CACHE_VALID,	/* Entry contains valid data */
> +	CACHE_NEGATIVE,	/* Negative entry - there is no match for the key */
> +	CACHE_PENDING,	/* An upcall has been sent but no reply received yet*/
> +	CACHE_CLEANED,	/* Entry has been cleaned from cache */
> +};

Weird comment of the day: Please use a double-tab before the comments
to leave room for larger flag names in the future.


>  #define	CACHE_NEW_EXPIRY 120	/* keep new things pending confirmation for 120 seconds */
>  
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index f3df7f963653..83f31a09c853 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -31,7 +31,7 @@
>   * node traffic on multi-node NUMA NFS servers.
>   */
>  struct svc_pool {
> -	unsigned int		sp_id;	    	/* pool id; also node id on NUMA */
> +	unsigned int		sp_id;		/* pool id; also node id on NUMA */
>  	spinlock_t		sp_lock;	/* protects all fields */
>  	struct list_head	sp_sockets;	/* pending sockets */
>  	unsigned int		sp_nrthreads;	/* # of threads in pool */
> @@ -44,12 +44,15 @@ struct svc_pool {
>  	struct percpu_counter	sp_threads_starved;
>  	struct percpu_counter	sp_threads_no_work;
>  
> -#define	SP_TASK_PENDING		(0)		/* still work to do even if no
> -						 * xprt is queued. */
> -#define SP_CONGESTED		(1)
>  	unsigned long		sp_flags;
>  } ____cacheline_aligned_in_smp;
>  
> +/* bits for sp_flags */
> +enum {
> +	SP_TASK_PENDING,	/* still work to do even if no xprt is queued */
> +	SP_CONGESTED,		/* all threads are busy, none idle */
> +};
> +
>  /*
>   * RPC service.
>   *
> @@ -232,16 +235,6 @@ struct svc_rqst {
>  	u32			rq_proc;	/* procedure number */
>  	u32			rq_prot;	/* IP protocol */
>  	int			rq_cachetype;	/* catering to nfsd */
> -#define	RQ_SECURE	(0)			/* secure port */
> -#define	RQ_LOCAL	(1)			/* local request */
> -#define	RQ_USEDEFERRAL	(2)			/* use deferral */
> -#define	RQ_DROPME	(3)			/* drop current reply */
> -#define	RQ_SPLICE_OK	(4)			/* turned off in gss privacy
> -						 * to prevent encrypting page
> -						 * cache pages */
> -#define	RQ_VICTIM	(5)			/* about to be shut down */
> -#define	RQ_BUSY		(6)			/* request is busy */
> -#define	RQ_DATA		(7)			/* request has data */
>  	unsigned long		rq_flags;	/* flags field */
>  	ktime_t			rq_qtime;	/* enqueue time */
>  
> @@ -272,6 +265,19 @@ struct svc_rqst {
>  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
>  };
>  
> +/* bits for rq_flags */
> +enum {
> +	RQ_SECURE,	/* secure port */
> +	RQ_LOCAL,	/* local request */
> +	RQ_USEDEFERRAL,	/* use deferral */
> +	RQ_DROPME,	/* drop current reply */
> +	RQ_SPLICE_OK,	/* turned off in gss privacy to prevent encrypting page
> +			 * cache pages */
> +	RQ_VICTIM,	/* about to be shut down */
> +	RQ_BUSY,	/* request is busy */
> +	RQ_DATA,	/* request has data */
> +};
> +

Also here -- two tab stops instead of one.


>  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
>  
>  /*
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
> index a6b12631db21..af383d0349b3 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -56,26 +56,9 @@ struct svc_xprt {
>  	struct list_head	xpt_list;
>  	struct list_head	xpt_ready;
>  	unsigned long		xpt_flags;
> -#define	XPT_BUSY	0		/* enqueued/receiving */
> -#define	XPT_CONN	1		/* conn pending */
> -#define	XPT_CLOSE	2		/* dead or dying */
> -#define	XPT_DATA	3		/* data pending */
> -#define	XPT_TEMP	4		/* connected transport */
> -#define	XPT_DEAD	6		/* transport closed */
> -#define	XPT_CHNGBUF	7		/* need to change snd/rcv buf sizes */
> -#define	XPT_DEFERRED	8		/* deferred request pending */
> -#define	XPT_OLD		9		/* used for xprt aging mark+sweep */
> -#define XPT_LISTENER	10		/* listening endpoint */
> -#define XPT_CACHE_AUTH	11		/* cache auth info */
> -#define XPT_LOCAL	12		/* connection from loopback interface */
> -#define XPT_KILL_TEMP   13		/* call xpo_kill_temp_xprt before closing */
> -#define XPT_CONG_CTRL	14		/* has congestion control */
> -#define XPT_HANDSHAKE	15		/* xprt requests a handshake */
> -#define XPT_TLS_SESSION	16		/* transport-layer security established */
> -#define XPT_PEER_AUTH	17		/* peer has been authenticated */
>  
>  	struct svc_serv		*xpt_server;	/* service for transport */
> -	atomic_t    	    	xpt_reserved;	/* space on outq that is rsvd */
> +	atomic_t		xpt_reserved;	/* space on outq that is rsvd */
>  	atomic_t		xpt_nr_rqsts;	/* Number of requests */
>  	struct mutex		xpt_mutex;	/* to serialize sending data */
>  	spinlock_t		xpt_lock;	/* protects sk_deferred
> @@ -96,6 +79,26 @@ struct svc_xprt {
>  	struct rpc_xprt		*xpt_bc_xprt;	/* NFSv4.1 backchannel */
>  	struct rpc_xprt_switch	*xpt_bc_xps;	/* NFSv4.1 backchannel */
>  };
> +/* flag bits for xpt_flags */
> +enum {
> +	XPT_BUSY,		/* enqueued/receiving */
> +	XPT_CONN,		/* conn pending */
> +	XPT_CLOSE,		/* dead or dying */
> +	XPT_DATA,		/* data pending */
> +	XPT_TEMP,		/* connected transport */
> +	XPT_DEAD,		/* transport closed */
> +	XPT_CHNGBUF,		/* need to change snd/rcv buf sizes */
> +	XPT_DEFERRED,		/* deferred request pending */
> +	XPT_OLD,		/* used for xprt aging mark+sweep */
> +	XPT_LISTENER,		/* listening endpoint */
> +	XPT_CACHE_AUTH,		/* cache auth info */
> +	XPT_LOCAL,		/* connection from loopback interface */
> +	XPT_KILL_TEMP,		/* call xpo_kill_temp_xprt before closing */
> +	XPT_CONG_CTRL,		/* has congestion control */
> +	XPT_HANDSHAKE,		/* xprt requests a handshake */
> +	XPT_TLS_SESSION,	/* transport-layer security established */
> +	XPT_PEER_AUTH,		/* peer has been authenticated */
> +};
>  
>  static inline void unregister_xpt_user(struct svc_xprt *xpt, struct svc_xpt_user *u)
>  {
> diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
> index 6d9cc9080aca..8d1d0d0721d2 100644
> --- a/include/linux/sunrpc/svcauth.h
> +++ b/include/linux/sunrpc/svcauth.h
> @@ -133,19 +133,22 @@ struct auth_ops {
>  	int	(*set_client)(struct svc_rqst *rq);
>  };
>  
> -#define	SVC_GARBAGE	1
> -#define	SVC_SYSERR	2
> -#define	SVC_VALID	3
> -#define	SVC_NEGATIVE	4
> -#define	SVC_OK		5
> -#define	SVC_DROP	6
> -#define	SVC_CLOSE	7	/* Like SVC_DROP, but request is definitely
> -				 * lost so if there is a tcp connection, it
> -				 * should be closed
> -				 */
> -#define	SVC_DENIED	8
> -#define	SVC_PENDING	9
> -#define	SVC_COMPLETE	10
> +/*return values for svc functions that analyse request */
> +enum {
> +	SVC_GARBAGE,
> +	SVC_SYSERR,
> +	SVC_VALID,
> +	SVC_NEGATIVE,
> +	SVC_OK,
> +	SVC_DROP,
> +	SVC_CLOSE,	/* Like SVC_DROP, but request is definitely
> +			 * lost so if there is a tcp connection, it
> +			 * should be closed
> +			 */
> +	SVC_DENIED,
> +	SVC_PENDING,
> +	SVC_COMPLETE,
> +};
>  
>  struct svc_xprt;
>  
> diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
> index 700a1e6c047c..1ed2f446010b 100644
> --- a/include/linux/sunrpc/xprtsock.h
> +++ b/include/linux/sunrpc/xprtsock.h
> @@ -81,17 +81,18 @@ struct sock_xprt {
>  };
>  
>  /*
> - * TCP RPC flags
> + * TCP RPC flags in ->sock_state
>   */
> -#define XPRT_SOCK_CONNECTING	1U
> -#define XPRT_SOCK_DATA_READY	(2)
> -#define XPRT_SOCK_UPD_TIMEOUT	(3)
> -#define XPRT_SOCK_WAKE_ERROR	(4)
> -#define XPRT_SOCK_WAKE_WRITE	(5)
> -#define XPRT_SOCK_WAKE_PENDING	(6)
> -#define XPRT_SOCK_WAKE_DISCONNECT	(7)
> -#define XPRT_SOCK_CONNECT_SENT	(8)
> -#define XPRT_SOCK_NOSPACE	(9)
> -#define XPRT_SOCK_IGNORE_RECV	(10)
> -
> +enum {
> +	XPRT_SOCK_CONNECTING,
> +	XPRT_SOCK_DATA_READY,
> +	XPRT_SOCK_UPD_TIMEOUT,
> +	XPRT_SOCK_WAKE_ERROR,
> +	XPRT_SOCK_WAKE_WRITE,
> +	XPRT_SOCK_WAKE_PENDING,
> +	XPRT_SOCK_WAKE_DISCONNECT,
> +	XPRT_SOCK_CONNECT_SENT,
> +	XPRT_SOCK_NOSPACE,
> +	XPRT_SOCK_IGNORE_RECV,
> +};
>  #endif /* _LINUX_SUNRPC_XPRTSOCK_H */
> 
> 

Let's not change client-side code in this patch. Please split this
hunk out and send it to Trond and Anna separately.

