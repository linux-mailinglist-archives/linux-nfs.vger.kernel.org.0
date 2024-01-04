Return-Path: <linux-nfs+bounces-942-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ECC82460B
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 17:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F031F22DF1
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 16:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9243E24B25;
	Thu,  4 Jan 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlXJ3hWL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D7D24B21
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 16:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E359AC433D9
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 16:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704385426;
	bh=lJv+O/ZOX72Ri2J4XLHmsa0n6cFcQpKttkxDsffUO20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QlXJ3hWLLs8SWpgmQ5mm9ar499xHtvo1u3f/6A/Jm+7qa9gdR7GI8N1RqXSPghYaa
	 2o8ofAPSCNow80QGbjYT2HIlfhV8+r5opLdPxCkzcJn3g6ywgHMOesmBbYEbSxvGJd
	 S9YLxhLWeX9HiLdOrj1rKLuoMLnd5AXeytNqnPKQcBqpEubHNSnQWwdsEwuCuu7iAO
	 EoPdOdMRhhPRa5uWpKd5FzPqd2VrspjCIySc0xP7FHZLvl4L5usZrVTukga0qzqzKK
	 b2/d5EljfJ5AqUSSZqF7asEliEI8iaSbqAi/6Cn9i8Q3l8InNAqv/vdTt2MGXvvshS
	 swEB9WutjPvmA==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7815aad83acso119389685a.0
        for <linux-nfs@vger.kernel.org>; Thu, 04 Jan 2024 08:23:46 -0800 (PST)
X-Gm-Message-State: AOJu0Ywa2ocBKNMJu5zTdjGo01FhUxH2dghuBKGUWB5k7O5Q4NAb0yFJ
	TON8evAoY0tOeAy5/J5zVuP4oMzndp2Hvcvrh7s=
X-Google-Smtp-Source: AGHT+IE7f4RIUtnQVdMk2ggPc/h/4DojOt561GUqUElSJMC3n2JzEoDBDk5zuGhBMcOdWJCT0dqTmbqSL0AlZOqXS5U=
X-Received: by 2002:a05:6214:20e3:b0:680:d242:67e4 with SMTP id
 3-20020a05621420e300b00680d24267e4mr950927qvk.22.1704385426058; Thu, 04 Jan
 2024 08:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1704379780.git.bcodding@redhat.com>
 <8a862f8ad3cb9f65decffb2956fb8674451af25c.1704379780.git.bcodding@redhat.com>
In-Reply-To: <8a862f8ad3cb9f65decffb2956fb8674451af25c.1704379780.git.bcodding@redhat.com>
From: Anna Schumaker <anna@kernel.org>
Date: Thu, 4 Jan 2024 11:23:29 -0500
X-Gmail-Original-Message-ID: <CAFX2JfnhF6JDhB22ke8AHT-4TjMBhHz8Lx-TRHrgz-vGeigr=g@mail.gmail.com>
Message-ID: <CAFX2JfnhF6JDhB22ke8AHT-4TjMBhHz8Lx-TRHrgz-vGeigr=g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] NFSv4.1: Use the nfs_client's rpc timeouts for backchannel
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, Jan 4, 2024 at 9:58=E2=80=AFAM Benjamin Coddington <bcodding@redhat=
.com> wrote:
>
> For backchannel requests that lookup the appropriate nfs_client, use the
> state-management rpc_clnt's rpc_timeout parameters for the backchannel's
> response.  When the nfs_client cannot be found, fall back to using the
> xprt's default timeout parameters.

Thanks for sending the v4, it fixes the problem I was seeing yesterday!

Anna

>
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  fs/nfs/callback_xdr.c          |  5 +++++
>  include/linux/sunrpc/bc_xprt.h |  3 ++-
>  include/linux/sunrpc/sched.h   | 14 +++++++++++++-
>  include/linux/sunrpc/svc.h     |  2 ++
>  include/linux/sunrpc/xprt.h    | 11 -----------
>  net/sunrpc/clnt.c              |  6 ++++--
>  net/sunrpc/svc.c               | 11 ++++++++++-
>  net/sunrpc/xprt.c              | 12 +++++++++---
>  8 files changed, 45 insertions(+), 19 deletions(-)
>
> diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
> index 321af81c456e..9369488f2ed4 100644
> --- a/fs/nfs/callback_xdr.c
> +++ b/fs/nfs/callback_xdr.c
> @@ -967,6 +967,11 @@ static __be32 nfs4_callback_compound(struct svc_rqst=
 *rqstp)
>                 nops--;
>         }
>
> +       if (svc_is_backchannel(rqstp) && cps.clp) {
> +               rqstp->bc_to_initval =3D cps.clp->cl_rpcclient->cl_timeou=
t->to_initval;
> +               rqstp->bc_to_retries =3D cps.clp->cl_rpcclient->cl_timeou=
t->to_retries;
> +       }
> +
>         *hdr_res.status =3D status;
>         *hdr_res.nops =3D htonl(nops);
>         nfs4_cb_free_slot(&cps);
> diff --git a/include/linux/sunrpc/bc_xprt.h b/include/linux/sunrpc/bc_xpr=
t.h
> index db30a159f9d5..f22bf915dcf6 100644
> --- a/include/linux/sunrpc/bc_xprt.h
> +++ b/include/linux/sunrpc/bc_xprt.h
> @@ -20,7 +20,8 @@
>  #ifdef CONFIG_SUNRPC_BACKCHANNEL
>  struct rpc_rqst *xprt_lookup_bc_request(struct rpc_xprt *xprt, __be32 xi=
d);
>  void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied);
> -void xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task);
> +void xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task,
> +               const struct rpc_timeout *to);
>  void xprt_free_bc_request(struct rpc_rqst *req);
>  int xprt_setup_backchannel(struct rpc_xprt *, unsigned int min_reqs);
>  void xprt_destroy_backchannel(struct rpc_xprt *, unsigned int max_reqs);
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index 8ada7dc802d3..2d61987b3545 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -37,6 +37,17 @@ struct rpc_wait {
>         struct list_head        timer_list;     /* Timer list */
>  };
>
> +/*
> + * This describes a timeout strategy
> + */
> +struct rpc_timeout {
> +       unsigned long           to_initval,             /* initial timeou=
t */
> +                               to_maxval,              /* max timeout */
> +                               to_increment;           /* if !exponentia=
l */
> +       unsigned int            to_retries;             /* max # of retri=
es */
> +       unsigned char           to_exponential;
> +};
> +
>  /*
>   * This is the RPC task struct
>   */
> @@ -205,7 +216,8 @@ struct rpc_wait_queue {
>   */
>  struct rpc_task *rpc_new_task(const struct rpc_task_setup *);
>  struct rpc_task *rpc_run_task(const struct rpc_task_setup *);
> -struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req);
> +struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req,
> +               struct rpc_timeout *timeout);
>  void           rpc_put_task(struct rpc_task *);
>  void           rpc_put_task_async(struct rpc_task *);
>  bool           rpc_task_set_rpc_status(struct rpc_task *task, int rpc_st=
atus);
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index b10f987509cc..3331a1c2b47e 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -250,6 +250,8 @@ struct svc_rqst {
>         struct net              *rq_bc_net;     /* pointer to backchannel=
's
>                                                  * net namespace
>                                                  */
> +       unsigned long   bc_to_initval;
> +       unsigned int    bc_to_retries;
>         void **                 rq_lease_breaker; /* The v4 client breaki=
ng a lease */
>         unsigned int            rq_status_counter; /* RPC processing coun=
ter */
>  };
> diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
> index f85d3a0daca2..464f6a9492ab 100644
> --- a/include/linux/sunrpc/xprt.h
> +++ b/include/linux/sunrpc/xprt.h
> @@ -30,17 +30,6 @@
>  #define RPC_MAXCWND(xprt)      ((xprt)->max_reqs << RPC_CWNDSHIFT)
>  #define RPCXPRT_CONGESTED(xprt) ((xprt)->cong >=3D (xprt)->cwnd)
>
> -/*
> - * This describes a timeout strategy
> - */
> -struct rpc_timeout {
> -       unsigned long           to_initval,             /* initial timeou=
t */
> -                               to_maxval,              /* max timeout */
> -                               to_increment;           /* if !exponentia=
l */
> -       unsigned int            to_retries;             /* max # of retri=
es */
> -       unsigned char           to_exponential;
> -};
> -
>  enum rpc_display_format_t {
>         RPC_DISPLAY_ADDR =3D 0,
>         RPC_DISPLAY_PORT,
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index daa9582ec861..886fc4c76558 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -1302,8 +1302,10 @@ static void call_bc_encode(struct rpc_task *task);
>   * rpc_run_bc_task - Allocate a new RPC task for backchannel use, then r=
un
>   * rpc_execute against it
>   * @req: RPC request
> + * @timeout: timeout values to use for this task
>   */
> -struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req)
> +struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req,
> +               struct rpc_timeout *timeout)
>  {
>         struct rpc_task *task;
>         struct rpc_task_setup task_setup_data =3D {
> @@ -1322,7 +1324,7 @@ struct rpc_task *rpc_run_bc_task(struct rpc_rqst *r=
eq)
>                 return task;
>         }
>
> -       xprt_init_bc_request(req, task);
> +       xprt_init_bc_request(req, task, timeout);
>
>         task->tk_action =3D call_bc_encode;
>         atomic_inc(&task->tk_count);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 3f2ea7a0496f..3f714d33624b 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1557,6 +1557,7 @@ void svc_process_bc(struct rpc_rqst *req, struct sv=
c_rqst *rqstp)
>  {
>         struct rpc_task *task;
>         int proc_error;
> +       struct rpc_timeout timeout;
>
>         /* Build the svc_rqst used by the common processing routine */
>         rqstp->rq_xid =3D req->rq_xid;
> @@ -1602,8 +1603,16 @@ void svc_process_bc(struct rpc_rqst *req, struct s=
vc_rqst *rqstp)
>                 return;
>         }
>         /* Finally, send the reply synchronously */
> +       if (rqstp->bc_to_initval > 0) {
> +               timeout.to_initval =3D rqstp->bc_to_initval;
> +               timeout.to_retries =3D rqstp->bc_to_initval;
> +       } else {
> +               timeout.to_initval =3D req->rq_xprt->timeout->to_initval;
> +               timeout.to_initval =3D req->rq_xprt->timeout->to_retries;
> +       }
>         memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf))=
;
> -       task =3D rpc_run_bc_task(req);
> +       task =3D rpc_run_bc_task(req, &timeout);
> +
>         if (IS_ERR(task))
>                 return;
>
> diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
> index 6cc9ffac962d..af13fdfa6672 100644
> --- a/net/sunrpc/xprt.c
> +++ b/net/sunrpc/xprt.c
> @@ -1986,7 +1986,8 @@ void xprt_release(struct rpc_task *task)
>
>  #ifdef CONFIG_SUNRPC_BACKCHANNEL
>  void
> -xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task)
> +xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task,
> +               const struct rpc_timeout *to)
>  {
>         struct xdr_buf *xbufp =3D &req->rq_snd_buf;
>
> @@ -1999,8 +2000,13 @@ xprt_init_bc_request(struct rpc_rqst *req, struct =
rpc_task *task)
>          */
>         xbufp->len =3D xbufp->head[0].iov_len + xbufp->page_len +
>                 xbufp->tail[0].iov_len;
> -
> -       xprt_init_majortimeo(task, req, req->rq_xprt->timeout);
> +       /*
> +        * Backchannel Replies are sent with !RPC_TASK_SOFT and
> +        * RPC_TASK_NO_RETRANS_TIMEOUT. The major timeout setting
> +        * affects only how long each Reply waits to be sent when
> +        * a transport connection cannot be established.
> +        */
> +       xprt_init_majortimeo(task, req, to);
>  }
>  #endif
>
> --
> 2.43.0
>

