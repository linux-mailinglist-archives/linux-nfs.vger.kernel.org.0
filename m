Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA05B769994
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 16:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjGaOdv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 10:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjGaOdu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 10:33:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B34D3
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jul 2023 07:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A5826117D
        for <linux-nfs@vger.kernel.org>; Mon, 31 Jul 2023 14:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F323C433C7;
        Mon, 31 Jul 2023 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690814028;
        bh=VmddOGqds86SdRxieOyMrDjvop1nXoX4tnuCfSukvQg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iLSJ/M1VWf2TOLo7Hfo9WPwW21egOgW+Btb5cftJ8WF4YTldL1Xpm55gdRkj60A4m
         4OhC5WwzcBxvUhKmLRU8NABzmh5D1j8en0QSGhJ/SaYEnjbWw99k8BGu0LuVUUUNa+
         l6NHdlUoRmpbhR20pgZbGzIqsIRLsuxFCQZF5ny2kcq404MYoi7lfmt429UGlojl18
         XUkFpwbwHGZxy4B478vvOLHjT1az6S9vEYcIylNZIWFcj4uYg2zn2iZXmEUpJhMGXq
         gue1lSasFEcRFq/zYSjYzgh79z86n/1e+aPdFAni9TuawIKouHwT4BwoF4eWOTbWQo
         4N7UVhI5o5eAw==
Message-ID: <0c4b0d2cec4d49a4ff845771b88bf26771b65ff5.camel@kernel.org>
Subject: Re: [PATCH 01/12] SUNRPC: make rqst_should_sleep() idempotent()
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 31 Jul 2023 10:33:47 -0400
In-Reply-To: <20230731064839.7729-2-neilb@suse.de>
References: <20230731064839.7729-1-neilb@suse.de>
         <20230731064839.7729-2-neilb@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-07-31 at 16:48 +1000, NeilBrown wrote:
> Based on its name you would think that rqst_should_sleep() would be
> read-only, not changing anything.  But it fact it will clear
> SP_TASK_PENDING if that was set.  This is surprising, and it blurs the
> line between "check for work to do" and "dequeue work to do".
>=20
> So change the "test_and_clear" to simple "test" and clear the bit once
> the thread has decided to wake up and return to the caller.
>=20
> With this, it makes sense to *always* set SP_TASK_PENDING when asked,
> rather than only to set it if no thread could be woken up.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  net/sunrpc/svc_xprt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index cd92cb54132d..380fb3caea4c 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -581,8 +581,8 @@ void svc_wake_up(struct svc_serv *serv)
>  {
>  	struct svc_pool *pool =3D &serv->sv_pools[0];
> =20
> -	if (!svc_pool_wake_idle_thread(serv, pool))
> -		set_bit(SP_TASK_PENDING, &pool->sp_flags);
> +	set_bit(SP_TASK_PENDING, &pool->sp_flags);
> +	svc_pool_wake_idle_thread(serv, pool);
>  }
>  EXPORT_SYMBOL_GPL(svc_wake_up);
> =20
> @@ -704,7 +704,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  	struct svc_pool		*pool =3D rqstp->rq_pool;
> =20
>  	/* did someone call svc_wake_up? */
> -	if (test_and_clear_bit(SP_TASK_PENDING, &pool->sp_flags))
> +	if (test_bit(SP_TASK_PENDING, &pool->sp_flags))
>  		return false;
> =20
>  	/* was a socket queued? */
> @@ -750,6 +750,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_=
rqst *rqstp)
> =20
>  	set_bit(RQ_BUSY, &rqstp->rq_flags);
>  	smp_mb__after_atomic();
> +	clear_bit(SP_TASK_PENDING, &pool->sp_flags);

Took me a few mins to decide that splitting up the test_and_clear_bit
didn't open a ToC/ToU race. I think we're saved by the fact that only
nfsd thread itself clears the bit, so we're guaranteed not to race with
another clear (whew).
=20
>  	rqstp->rq_xprt =3D svc_xprt_dequeue(pool);
>  	if (rqstp->rq_xprt) {
>  		trace_svc_pool_awoken(rqstp);
> @@ -761,6 +762,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_=
rqst *rqstp)
>  	percpu_counter_inc(&pool->sp_threads_no_work);
>  	return NULL;
>  out_found:
> +	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
>  	/* Normally we will wait up to 5 seconds for any required
>  	 * cache information to be provided.
>  	 */

Reviewed-by: Jeff Layton <jlayton@kernel.org>
