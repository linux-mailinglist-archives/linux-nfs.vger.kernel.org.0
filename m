Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A06049BDFC
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 22:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiAYVw0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 16:52:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43618 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiAYVw0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 16:52:26 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 22431210EC;
        Tue, 25 Jan 2022 21:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643147545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yx2gW6fg2iTQnUCwu329VI2uW5MudEVFc/suWL1+kbA=;
        b=C5A7KCGSq3d3cBeAG+4Kc9aNUbNqHsCiepnspGdtZKqPJ+vtjvqhx1NW24hzZF/PCGMk+A
        /C4y+RuYLfcR5oSd8H1AQF46ECJ+Pl9QjZ0Nz/3EWD6LIrZjmH3ruZ9adWZ/DuvD0/h27Y
        qFgU+z6qmu7skLv+O2ZAZTJ8xZuJWp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643147545;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yx2gW6fg2iTQnUCwu329VI2uW5MudEVFc/suWL1+kbA=;
        b=zjMo9yxaCoZ4FAGtHKNmI76uNchQvLLgoWYY2H2razJVQZNpFZZaSFRy30S10EGtJ+cLmn
        Y16udMFiAEJ+DHBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4421813A05;
        Tue, 25 Jan 2022 21:52:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rsAnARhx8GFOQgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 25 Jan 2022 21:52:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 1/2] SUNRPC: Remove the .svo_enqueue_xprt method
In-reply-to: <164313724534.3285.9750535460628123459.stgit@bazille.1015granger.net>
References: <164313706374.3285.4265550102084857832.stgit@bazille.1015granger.net>,
 <164313724534.3285.9750535460628123459.stgit@bazille.1015granger.net>
Date:   Wed, 26 Jan 2022 08:52:20 +1100
Message-id: <164314754074.5493.14293310085265589336@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 26 Jan 2022, Chuck Lever wrote:
> We have never been able to track down and address the underlying
> cause of the performance issues with workqueue-based service
> support. svo_enqueue_xprt is called multiple times per RPC, so
> it adds instruction path length, but always ends up at the same
> function: svc_xprt_do_enqueue(). We do not anticipate needing
> this flexibility for dynamic nfsd thread management support.
>=20
> As a micro-optimization, remove .svo_enqueue_xprt because
> Spectre/Meltdown makes virtual function calls more costly.
>=20
> This change essentially reverts commit b9e13cdfac70 ("nfsd/sunrpc:
> turn enqueueing a svc_xprt into a svc_serv operation").
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/lockd/svc.c                  |    1 -
>  fs/nfs/callback.c               |    2 --
>  fs/nfsd/nfssvc.c                |    1 -
>  include/linux/sunrpc/svc.h      |    3 ---
>  include/linux/sunrpc/svc_xprt.h |    1 -
>  net/sunrpc/svc_xprt.c           |   10 +++++-----
>  6 files changed, 5 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 0475c5a5d061..3a05af873625 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -353,7 +353,6 @@ static struct notifier_block lockd_inet6addr_notifier =
=3D {
>  static const struct svc_serv_ops lockd_sv_ops =3D {
>  	.svo_shutdown		=3D svc_rpcb_cleanup,
>  	.svo_function		=3D lockd,
> -	.svo_enqueue_xprt	=3D svc_xprt_do_enqueue,
>  	.svo_module		=3D THIS_MODULE,
>  };
> =20
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 054cc1255fac..7a810f885063 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -234,13 +234,11 @@ static int nfs_callback_up_net(int minorversion, stru=
ct svc_serv *serv,
> =20
>  static const struct svc_serv_ops nfs40_cb_sv_ops =3D {
>  	.svo_function		=3D nfs4_callback_svc,
> -	.svo_enqueue_xprt	=3D svc_xprt_do_enqueue,
>  	.svo_module		=3D THIS_MODULE,
>  };
>  #if defined(CONFIG_NFS_V4_1)
>  static const struct svc_serv_ops nfs41_cb_sv_ops =3D {
>  	.svo_function		=3D nfs41_callback_svc,
> -	.svo_enqueue_xprt	=3D svc_xprt_do_enqueue,
>  	.svo_module		=3D THIS_MODULE,
>  };
> =20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index b8c682b62d29..aeeac6de1f0a 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -615,7 +615,6 @@ static int nfsd_get_default_max_blksize(void)
>  static const struct svc_serv_ops nfsd_thread_sv_ops =3D {
>  	.svo_shutdown		=3D nfsd_last_thread,
>  	.svo_function		=3D nfsd,
> -	.svo_enqueue_xprt	=3D svc_xprt_do_enqueue,
>  	.svo_module		=3D THIS_MODULE,
>  };
> =20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index f35c22b3355f..6ef9c1cafd0b 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -61,9 +61,6 @@ struct svc_serv_ops {
>  	/* function for service threads to run */
>  	int		(*svo_function)(void *);
> =20
> -	/* queue up a transport for servicing */
> -	void		(*svo_enqueue_xprt)(struct svc_xprt *);
> -
>  	/* optional module to count when adding threads.
>  	 * Thread function must call module_put_and_kthread_exit() to exit.
>  	 */
> diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xpr=
t.h
> index 571f605bc91e..a3ba027fb4ba 100644
> --- a/include/linux/sunrpc/svc_xprt.h
> +++ b/include/linux/sunrpc/svc_xprt.h
> @@ -131,7 +131,6 @@ int	svc_create_xprt(struct svc_serv *, const char *, st=
ruct net *,
>  			const int, const unsigned short, int,
>  			const struct cred *);
>  void	svc_xprt_received(struct svc_xprt *xprt);
> -void	svc_xprt_do_enqueue(struct svc_xprt *xprt);
>  void	svc_xprt_enqueue(struct svc_xprt *xprt);
>  void	svc_xprt_put(struct svc_xprt *xprt);
>  void	svc_xprt_copy_addrs(struct svc_rqst *rqstp, struct svc_xprt *xprt);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index b21ad7994147..9fce4f7774bb 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -32,6 +32,7 @@ static int svc_deferred_recv(struct svc_rqst *rqstp);
>  static struct cache_deferred_req *svc_defer(struct cache_req *req);
>  static void svc_age_temp_xprts(struct timer_list *t);
>  static void svc_delete_xprt(struct svc_xprt *xprt);
> +static void svc_xprt_do_enqueue(struct svc_xprt *xprt);
> =20
>  /* apparently the "standard" is that clients close
>   * idle connections after 5 minutes, servers after
> @@ -266,12 +267,12 @@ void svc_xprt_received(struct svc_xprt *xprt)
>  	}
> =20
>  	/* As soon as we clear busy, the xprt could be closed and
> -	 * 'put', so we need a reference to call svc_enqueue_xprt with:
> +	 * 'put', so we need a reference to call svc_xprt_do_enqueue with:
>  	 */
>  	svc_xprt_get(xprt);
>  	smp_mb__before_atomic();
>  	clear_bit(XPT_BUSY, &xprt->xpt_flags);
> -	xprt->xpt_server->sv_ops->svo_enqueue_xprt(xprt);
> +	svc_xprt_do_enqueue(xprt);
>  	svc_xprt_put(xprt);
>  }
>  EXPORT_SYMBOL_GPL(svc_xprt_received);
> @@ -423,7 +424,7 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
>  	return false;
>  }
> =20
> -void svc_xprt_do_enqueue(struct svc_xprt *xprt)
> +static void svc_xprt_do_enqueue(struct svc_xprt *xprt)
>  {
>  	struct svc_pool *pool;
>  	struct svc_rqst	*rqstp =3D NULL;
> @@ -467,7 +468,6 @@ void svc_xprt_do_enqueue(struct svc_xprt *xprt)
>  	put_cpu();
>  	trace_svc_xprt_enqueue(xprt, rqstp);
>  }
> -EXPORT_SYMBOL_GPL(svc_xprt_do_enqueue);
> =20
>  /*
>   * Queue up a transport with data pending. If there are idle nfsd
> @@ -478,7 +478,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
>  {
>  	if (test_bit(XPT_BUSY, &xprt->xpt_flags))
>  		return;
> -	xprt->xpt_server->sv_ops->svo_enqueue_xprt(xprt);
> +	svc_xprt_do_enqueue(xprt);
>  }
>  EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
> =20

I obviously like this, but I think we can do better - merge
svc_xprt_enqueue and svc_xprt_do_enqueue, and drop the extra test on
XPT_BUSY.
They were separated in Commit 0971374e2818 ("SUNRPC: Reduce contention
in svc_xprt_enqueue()") so that the XPT_BUSY check happened before
taking any spinlocks.
We have since moved or removed the spinlocks so the extra test is fairly
pointless.

Possibly we could add
  if (xpt_flags & BIT(XPR_BUSY))
        return false;
at the start of svc_xprt_ready().  It would make sense there and be
close to free.

Thanks,
NeilBrown
