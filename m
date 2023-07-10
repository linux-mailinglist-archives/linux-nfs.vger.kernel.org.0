Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39A874E111
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 00:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjGJW3W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 18:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjGJW3V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 18:29:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50763C4
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 15:29:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0BC66201E9;
        Mon, 10 Jul 2023 22:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689028159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udDafUzbbgLUnHoR7/UCbquT4KIs+Ncx70XFO+vg1AA=;
        b=A4HrGXpVc8yFvp2zlm/tpgLm3oJXlNhGA0e0uPcrinrwhMjsFUMkdCWfBRCcFWBes4jMR5
        hNUFuYU9Jz9hjwRRLNc1cHp4gZOMVDpK94FiL4yS6DQ9nMEbisL7HN90kZBSR5wQMeJYdW
        7MSaGT89S20/zhcyXk7eMM7QFEIHS4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689028159;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=udDafUzbbgLUnHoR7/UCbquT4KIs+Ncx70XFO+vg1AA=;
        b=cZFtxwwy3B+Yfm8DSaVNGDVSoQ8iJg8dDpXQrS4kaUBCgMUE7jvd6J289uapUKuL8xUvtm
        o5VCNPvNTyLuKLAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D74AF1361C;
        Mon, 10 Jul 2023 22:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K/UfIjyGrGRPewAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 10 Jul 2023 22:29:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH v3 5/9] SUNRPC: Count pool threads that were awoken but
 found no work to do
In-reply-to: <168900734678.7514.887270657845753276.stgit@manet.1015granger.net>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>,
 <168900734678.7514.887270657845753276.stgit@manet.1015granger.net>
Date:   Tue, 11 Jul 2023 08:29:13 +1000
Message-id: <168902815363.8939.4838920400288577480@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 11 Jul 2023, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Measure a source of thread scheduling inefficiency -- count threads
> that were awoken but found that the transport queue had already been
> emptied.
>=20
> An empty transport queue is possible when threads that run between
> the wake_up_process() call and the woken thread returning from the
> scheduler have pulled all remaining work off the transport queue
> using the first svc_xprt_dequeue() in svc_get_next_xprt().

I'm in two minds about this.  The data being gathered here is
potentially useful - but who it is useful to?
I think it is primarily useful for us - to understand the behaviour of
the implementation so we can know what needs to be optimised.
It isn't really of any use to a sysadmin who wants to understand how
their system is performing.

But then .. who are tracepoints for?  Developers or admins?
I guess that fact that we feel free to modify them whenever we need
means they are primarily for developers?  In which case this is a good
patch, and maybe we'll revert the functionality one day if it turns out
that we can change the implementation so that a thread is never woken
when there is no work to do ....

Thanks,
NeilBrown


>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/svc.h |    1 +
>  net/sunrpc/svc.c           |    2 ++
>  net/sunrpc/svc_xprt.c      |    7 ++++---
>  3 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 74ea13270679..9dd3b16cc4c2 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -43,6 +43,7 @@ struct svc_pool {
>  	struct percpu_counter	sp_threads_woken;
>  	struct percpu_counter	sp_threads_timedout;
>  	struct percpu_counter	sp_threads_starved;
> +	struct percpu_counter	sp_threads_no_work;
> =20
>  #define	SP_TASK_PENDING		(0)		/* still work to do even if no
>  						 * xprt is queued. */
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 88b7b5fb6d75..b7a02309ecb1 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -518,6 +518,7 @@ __svc_create(struct svc_program *prog, unsigned int buf=
size, int npools,
>  		percpu_counter_init(&pool->sp_threads_woken, 0, GFP_KERNEL);
>  		percpu_counter_init(&pool->sp_threads_timedout, 0, GFP_KERNEL);
>  		percpu_counter_init(&pool->sp_threads_starved, 0, GFP_KERNEL);
> +		percpu_counter_init(&pool->sp_threads_no_work, 0, GFP_KERNEL);
>  	}
> =20
>  	return serv;
> @@ -595,6 +596,7 @@ svc_destroy(struct kref *ref)
>  		percpu_counter_destroy(&pool->sp_threads_woken);
>  		percpu_counter_destroy(&pool->sp_threads_timedout);
>  		percpu_counter_destroy(&pool->sp_threads_starved);
> +		percpu_counter_destroy(&pool->sp_threads_no_work);
>  	}
>  	kfree(serv->sv_pools);
>  	kfree(serv);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index ecbccf0d89b9..6c2a702aa469 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -776,9 +776,9 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rq=
st *rqstp, long timeout)
> =20
>  	if (!time_left)
>  		percpu_counter_inc(&pool->sp_threads_timedout);
> -
>  	if (signalled() || kthread_should_stop())
>  		return ERR_PTR(-EINTR);
> +	percpu_counter_inc(&pool->sp_threads_no_work);
>  	return ERR_PTR(-EAGAIN);
>  out_found:
>  	/* Normally we will wait up to 5 seconds for any required
> @@ -1445,13 +1445,14 @@ static int svc_pool_stats_show(struct seq_file *m, =
void *p)
>  		return 0;
>  	}
> =20
> -	seq_printf(m, "%u %llu %llu %llu %llu %llu\n",
> +	seq_printf(m, "%u %llu %llu %llu %llu %llu %llu\n",
>  		pool->sp_id,
>  		percpu_counter_sum_positive(&pool->sp_messages_arrived),
>  		percpu_counter_sum_positive(&pool->sp_sockets_queued),
>  		percpu_counter_sum_positive(&pool->sp_threads_woken),
>  		percpu_counter_sum_positive(&pool->sp_threads_timedout),
> -		percpu_counter_sum_positive(&pool->sp_threads_starved));
> +		percpu_counter_sum_positive(&pool->sp_threads_starved),
> +		percpu_counter_sum_positive(&pool->sp_threads_no_work));
> =20
>  	return 0;
>  }
>=20
>=20
>=20

