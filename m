Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B887466B1
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 02:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGDA4R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 20:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGDA4R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 20:56:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D235A136
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 17:56:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 625DA22049;
        Tue,  4 Jul 2023 00:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688432174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIfJqO42Mtbh9ALjJGyZpdB4QlBSMQdQQCq3P+2s49M=;
        b=lfDI5Uaq3VkymR5XWfzZmkXTz+cc5BdOAau0SkiLhnFrktP92dboBj5W1D9rrcuB05M+Bk
        mPfeV+liE+j6MmIKHeIbV1R5mALR6F3mvXBScb1XxdJ8ERT0WOIWluPrvxG7sdAnjXX6d4
        cSPwXdJ7ONYbDxXG5NB8WzkhMU+0HS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688432174;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIfJqO42Mtbh9ALjJGyZpdB4QlBSMQdQQCq3P+2s49M=;
        b=0JLnginx1jHsmOcbu//uwG0eCz6Z7I2TMeWRvGNUCwQXvPffO8LGblbOBYvZbEmYomccgV
        ikt08KANRAjFwKDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F8B013276;
        Tue,  4 Jul 2023 00:56:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /P23NCtuo2SmcQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 04 Jul 2023 00:56:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH v2 7/9] SUNRPC: Don't disable BH's when taking sp_lock
In-reply-to: <168842929557.139194.4420161035549339648.stgit@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>,
 <168842929557.139194.4420161035549339648.stgit@manet.1015granger.net>
Date:   Tue, 04 Jul 2023 10:56:08 +1000
Message-id: <168843216897.8939.13310930289540832368@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 04 Jul 2023, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Consumers of sp_lock now all run in process context. We can avoid
> the overhead of disabling bottom halves when taking this lock.

"now" suggests that something has recently changed so that sp_lock isn't
taken in bh context.  What was that change - I don't see it.

I think svc_data_ready() is called in bh, and that calls
svc_xprt_enqueue() which take sp_lock to add the xprt to ->sp_sockets.=20

Is that not still the case?

NeilBrown


>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/svc_xprt.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index ecbccf0d89b9..8ced7591ce07 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -472,9 +472,9 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
>  	pool =3D svc_pool_for_cpu(xprt->xpt_server);
> =20
>  	percpu_counter_inc(&pool->sp_sockets_queued);
> -	spin_lock_bh(&pool->sp_lock);
> +	spin_lock(&pool->sp_lock);
>  	list_add_tail(&xprt->xpt_ready, &pool->sp_sockets);
> -	spin_unlock_bh(&pool->sp_lock);
> +	spin_unlock(&pool->sp_lock);
> =20
>  	rqstp =3D svc_pool_wake_idle_thread(xprt->xpt_server, pool);
>  	if (!rqstp) {
> @@ -496,14 +496,14 @@ static struct svc_xprt *svc_xprt_dequeue(struct svc_p=
ool *pool)
>  	if (list_empty(&pool->sp_sockets))
>  		goto out;
> =20
> -	spin_lock_bh(&pool->sp_lock);
> +	spin_lock(&pool->sp_lock);
>  	if (likely(!list_empty(&pool->sp_sockets))) {
>  		xprt =3D list_first_entry(&pool->sp_sockets,
>  					struct svc_xprt, xpt_ready);
>  		list_del_init(&xprt->xpt_ready);
>  		svc_xprt_get(xprt);
>  	}
> -	spin_unlock_bh(&pool->sp_lock);
> +	spin_unlock(&pool->sp_lock);
>  out:
>  	return xprt;
>  }
> @@ -1116,15 +1116,15 @@ static struct svc_xprt *svc_dequeue_net(struct svc_=
serv *serv, struct net *net)
>  	for (i =3D 0; i < serv->sv_nrpools; i++) {
>  		pool =3D &serv->sv_pools[i];
> =20
> -		spin_lock_bh(&pool->sp_lock);
> +		spin_lock(&pool->sp_lock);
>  		list_for_each_entry_safe(xprt, tmp, &pool->sp_sockets, xpt_ready) {
>  			if (xprt->xpt_net !=3D net)
>  				continue;
>  			list_del_init(&xprt->xpt_ready);
> -			spin_unlock_bh(&pool->sp_lock);
> +			spin_unlock(&pool->sp_lock);
>  			return xprt;
>  		}
> -		spin_unlock_bh(&pool->sp_lock);
> +		spin_unlock(&pool->sp_lock);
>  	}
>  	return NULL;
>  }
>=20
>=20
>=20

