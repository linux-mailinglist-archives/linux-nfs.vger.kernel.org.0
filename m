Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB15C744214
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 20:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjF3SV3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Jun 2023 14:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjF3SV2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 30 Jun 2023 14:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4C33ABF
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688149239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzhuUMbxyhaxpA7LIW6PX1Alu63xirY6QAKLCoB62Lo=;
        b=OAKGw91MJtsf8/FfEggl4kF/W88bnwWXFKhpx60o2KA/Ptmt/fT95Yu66pjNpIf++xNP4l
        m5koAYO20VOyQWXR6E2LjySaCkEb6XTYPlhzTXlFXi4QVi3Vr4Xcab9nr29akoVTzU+st9
        pEYa6NnepH5VphDzMzS+ggTX/KePB/Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-_cc-4cjgNKKHUrJqZAPRzw-1; Fri, 30 Jun 2023 14:20:37 -0400
X-MC-Unique: _cc-4cjgNKKHUrJqZAPRzw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635d9e482f1so21774226d6.1
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 11:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688149237; x=1690741237;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PzhuUMbxyhaxpA7LIW6PX1Alu63xirY6QAKLCoB62Lo=;
        b=JU2DFYJSUluScS7bv5KxbCPLNKr8JhXj4rEp1ujoqEy2n6m0SQzvaZpYNzDlXptfkB
         4IbnWI6HLiWk2vCvmonTcChDT+9pOckAYqGyBGWMb6ccxTULi+3PyMFZwUNVtNHFxbEC
         Qj/javrCP8vJhe6kEllUPcRVaVxObl4fVZOGj9m5rfJmbHguU/AaSjRBGSXIaNVk82be
         65WlVPIX+VBs/6LdqIwP7PrLTFV1bcqwYRgi8NJ39icbpnKznq7NUav7RjQosQOF5O8C
         JUpYr29Dy7Jez8MGglwKXnaeoqX9scXajYVGTIxlsd2HSz/zaeXs1cLEqgsCM5CY99Wb
         DouQ==
X-Gm-Message-State: ABy/qLYLv8HkLygTr9kR13V1GyzGRTSFkrGeKbl4WHxHC9fmygHbMUCy
        yJg5SUxWV5vo7llARVRqLsXat0119CWyCpl3+ujvkmP2q12P2jkfduo3wM1LyBgfhpXe4Bp/FGR
        6snxNXc9dbGbAUmahQRNB
X-Received: by 2002:a05:6214:188a:b0:635:e261:798d with SMTP id cx10-20020a056214188a00b00635e261798dmr3155573qvb.52.1688149236930;
        Fri, 30 Jun 2023 11:20:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG1mSghPcab9hTBFt4V4gZ1sUyPU6Ls8tfVHuuWHVOeAOBF3Vr0GA4bNMiOb0tySl1+kHN8lA==
X-Received: by 2002:a05:6214:188a:b0:635:e261:798d with SMTP id cx10-20020a056214188a00b00635e261798dmr3155561qvb.52.1688149236652;
        Fri, 30 Jun 2023 11:20:36 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id m12-20020a0cfbac000000b0063007ccaf42sm8164579qvp.57.2023.06.30.11.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:20:36 -0700 (PDT)
Message-ID: <cb7d61520824ca69d5d933c046d044ea78787041.camel@redhat.com>
Subject: Re: [PATCH RFC 1/8] SUNRPC: Deduplicate thread wake-up code
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, lorenzo@kernel.org,
        neilb@suse.de, david@fromorbit.com
Date:   Fri, 30 Jun 2023 14:20:34 -0400
In-Reply-To: <168806415041.1034990.11822594910002824781.stgit@morisot.1015granger.net>
References: <168806401782.1034990.9686296943273298604.stgit@morisot.1015granger.net>
         <168806415041.1034990.11822594910002824781.stgit@morisot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-06-29 at 14:42 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Refactor: Extract the loop that finds an idle service thread from
> svc_xprt_enqueue() and svc_wake_up().
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h |    1 +
>  net/sunrpc/svc.c           |   28 +++++++++++++++++++++++++++
>  net/sunrpc/svc_xprt.c      |   46 +++++++++++++-------------------------=
------
>  3 files changed, 43 insertions(+), 32 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index f8751118c122..dc2d90a655e2 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -427,6 +427,7 @@ int		   svc_register(const struct svc_serv *, struct =
net *, const int,
> =20
>  void		   svc_wake_up(struct svc_serv *);
>  void		   svc_reserve(struct svc_rqst *rqstp, int space);
> +struct svc_rqst	  *svc_pool_wake_idle_thread(struct svc_pool *pool);
>  struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
>  char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
>  const char *	   svc_proc_name(const struct svc_rqst *rqstp);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 587811a002c9..e81ce5f76abd 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -689,6 +689,34 @@ svc_prepare_thread(struct svc_serv *serv, struct svc=
_pool *pool, int node)
>  	return rqstp;
>  }
> =20
> +/**
> + * svc_pool_wake_idle_thread - wake an idle thread in @pool
> + * @pool: service thread pool
> + *
> + * Returns an idle service thread (now marked BUSY), or NULL
> + * if no service threads are available. Finding an idle service
> + * thread and marking it BUSY is atomic with respect to other
> + * calls to svc_pool_wake_idle_thread().
> + */
> +struct svc_rqst *svc_pool_wake_idle_thread(struct svc_pool *pool)
> +{
> +	struct svc_rqst	*rqstp;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
> +		if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
> +			continue;
> +
> +		rcu_read_unlock();
> +		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
> +		wake_up_process(rqstp->rq_task);
> +		percpu_counter_inc(&pool->sp_threads_woken);
> +		return rqstp;
> +	}
> +	rcu_read_unlock();
> +	return NULL;
> +}
> +
>  /*
>   * Choose a pool in which to create a new thread, for svc_set_num_thread=
s
>   */
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 62c7919ea610..f14476d11b67 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -455,8 +455,8 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
>   */
>  void svc_xprt_enqueue(struct svc_xprt *xprt)
>  {
> +	struct svc_rqst	*rqstp;
>  	struct svc_pool *pool;
> -	struct svc_rqst	*rqstp =3D NULL;
> =20
>  	if (!svc_xprt_ready(xprt))
>  		return;
> @@ -476,20 +476,10 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
>  	list_add_tail(&xprt->xpt_ready, &pool->sp_sockets);
>  	spin_unlock_bh(&pool->sp_lock);
> =20
> -	/* find a thread for this xprt */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
> -		if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
> -			continue;
> -		percpu_counter_inc(&pool->sp_threads_woken);
> -		rqstp->rq_qtime =3D ktime_get();
> -		wake_up_process(rqstp->rq_task);
> -		goto out_unlock;
> -	}
> -	set_bit(SP_CONGESTED, &pool->sp_flags);
> -	rqstp =3D NULL;
> -out_unlock:
> -	rcu_read_unlock();
> +	rqstp =3D svc_pool_wake_idle_thread(pool);
> +	if (!rqstp)
> +		set_bit(SP_CONGESTED, &pool->sp_flags);
> +
>  	trace_svc_xprt_enqueue(xprt, rqstp);
>  }
>  EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
> @@ -581,7 +571,10 @@ static void svc_xprt_release(struct svc_rqst *rqstp)
>  	svc_xprt_put(xprt);
>  }
> =20
> -/*
> +/**
> + * svc_wake_up - Wake up a service thread for non-transport work
> + * @serv: RPC service
> + *
>   * Some svc_serv's will have occasional work to do, even when a xprt is =
not
>   * waiting to be serviced. This function is there to "kick" a task in on=
e of
>   * those services so that it can wake up and do that work. Note that we =
only
> @@ -590,27 +583,16 @@ static void svc_xprt_release(struct svc_rqst *rqstp=
)
>   */
>  void svc_wake_up(struct svc_serv *serv)
>  {
> +	struct svc_pool *pool =3D &serv->sv_pools[0];
>  	struct svc_rqst	*rqstp;
> -	struct svc_pool *pool;
> =20
> -	pool =3D &serv->sv_pools[0];
> -
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
> -		/* skip any that aren't queued */
> -		if (test_bit(RQ_BUSY, &rqstp->rq_flags))
> -			continue;
> -		rcu_read_unlock();
> -		wake_up_process(rqstp->rq_task);
> -		trace_svc_wake_up(rqstp->rq_task->pid);
> +	rqstp =3D svc_pool_wake_idle_thread(pool);
> +	if (!rqstp) {
> +		set_bit(SP_TASK_PENDING, &pool->sp_flags);

nit: it might be good to add this here, for better conformance with the
old tracepoint behavior:

		trace_svc_wake_up(0);

>  		return;
>  	}
> -	rcu_read_unlock();
> =20
> -	/* No free entries available */
> -	set_bit(SP_TASK_PENDING, &pool->sp_flags);
> -	smp_wmb();

I assume this wmb was for the set_bit above? Do we need that in the
!rqstp case?

> -	trace_svc_wake_up(0);
> +	trace_svc_wake_up(rqstp->rq_task->pid);
>  }
>  EXPORT_SYMBOL_GPL(svc_wake_up);
> =20

