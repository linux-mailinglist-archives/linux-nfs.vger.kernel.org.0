Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0D49BE02
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 22:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiAYVx7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 16:53:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37088 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiAYVx7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 16:53:59 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD3281F388;
        Tue, 25 Jan 2022 21:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643147637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KpPd33BeLnx8hjnpAPo7UZsyQ/Ye2iHGQvYIiFZWkNo=;
        b=S/QwgMt7q3QnLAD4L4WqU017g1FWhQ5/G3pysxyyI5am/uprtIwo1A7gmdhuQv8u6pv7rx
        9zqALR4Yl3xQT7PGsJ0ayyJqpQgtzRAmegCy7aqyxCjD+JHlKWtS46Er6eqNpLvaLYGoHR
        yHy6Ywuh1pHex5X1ZKJcVF/aOCWmgW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643147637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KpPd33BeLnx8hjnpAPo7UZsyQ/Ye2iHGQvYIiFZWkNo=;
        b=e77r5jTLukFVE4BHgv87/QAFvhQ1nXaLZ8MSfLP/rttNvGguppJ1L7Y2IN5XcRsi4R6dTn
        EkNZGpJVIvVO8wCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 172E913A05;
        Tue, 25 Jan 2022 21:53:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RQbUMXRx8GEFQwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 25 Jan 2022 21:53:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 2/2] SUNRPC: Remove svo_shutdown method
In-reply-to: <164313725230.3285.5420060785593218794.stgit@bazille.1015granger.net>
References: <164313706374.3285.4265550102084857832.stgit@bazille.1015granger.net>,
 <164313725230.3285.5420060785593218794.stgit@bazille.1015granger.net>
Date:   Wed, 26 Jan 2022 08:53:53 +1100
Message-id: <164314763348.5493.760625882164316264@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 26 Jan 2022, Chuck Lever wrote:
> Clean up. Neil observed that "any code that calls svc_shutdown_net()
> knows what the shutdown function should be, and so can call it
> directly."
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/lockd/svc.c             |    5 ++---
>  fs/nfsd/nfssvc.c           |    2 +-
>  include/linux/sunrpc/svc.h |    3 ---
>  net/sunrpc/svc.c           |    3 ---
>  4 files changed, 3 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 3a05af873625..f5b688a844aa 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -249,6 +249,7 @@ static int make_socks(struct svc_serv *serv, struct net=
 *net,
>  		printk(KERN_WARNING
>  			"lockd_up: makesock failed, error=3D%d\n", err);
>  	svc_shutdown_net(serv, net);
> +	svc_rpcb_cleanup(serv, net);
>  	return err;
>  }
> =20
> @@ -287,8 +288,7 @@ static void lockd_down_net(struct svc_serv *serv, struc=
t net *net)
>  			cancel_delayed_work_sync(&ln->grace_period_end);
>  			locks_end_grace(&ln->lockd_manager);
>  			svc_shutdown_net(serv, net);
> -			dprintk("%s: per-net data destroyed; net=3D%x\n",
> -				__func__, net->ns.inum);
> +			svc_rpcb_cleanup(serv, net);
>  		}
>  	} else {
>  		pr_err("%s: no users! net=3D%x\n",
> @@ -351,7 +351,6 @@ static struct notifier_block lockd_inet6addr_notifier =
=3D {
>  #endif
> =20
>  static const struct svc_serv_ops lockd_sv_ops =3D {
> -	.svo_shutdown		=3D svc_rpcb_cleanup,
>  	.svo_function		=3D lockd,
>  	.svo_module		=3D THIS_MODULE,
>  };
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index aeeac6de1f0a..0c6b216e439e 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -613,7 +613,6 @@ static int nfsd_get_default_max_blksize(void)
>  }
> =20
>  static const struct svc_serv_ops nfsd_thread_sv_ops =3D {
> -	.svo_shutdown		=3D nfsd_last_thread,
>  	.svo_function		=3D nfsd,
>  	.svo_module		=3D THIS_MODULE,
>  };
> @@ -724,6 +723,7 @@ void nfsd_put(struct net *net)
> =20
>  	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
>  		svc_shutdown_net(nn->nfsd_serv, net);
> +		nfsd_last_thread(nn->nfsd_serv, net);
>  		svc_destroy(&nn->nfsd_serv->sv_refcnt);
>  		spin_lock(&nfsd_notifier_lock);
>  		nn->nfsd_serv =3D NULL;
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 6ef9c1cafd0b..63794d772eb3 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -55,9 +55,6 @@ struct svc_pool {
>  struct svc_serv;
> =20
>  struct svc_serv_ops {
> -	/* Callback to use when last thread exits. */
> -	void		(*svo_shutdown)(struct svc_serv *, struct net *);
> -
>  	/* function for service threads to run */
>  	int		(*svo_function)(void *);
> =20
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 2aabec2b4bec..74a75a22da9a 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -539,9 +539,6 @@ EXPORT_SYMBOL_GPL(svc_create_pooled);
>  void svc_shutdown_net(struct svc_serv *serv, struct net *net)
>  {
>  	svc_close_net(serv, net);
> -
> -	if (serv->sv_ops->svo_shutdown)
> -		serv->sv_ops->svo_shutdown(serv, net);
>  }
>  EXPORT_SYMBOL_GPL(svc_shutdown_net);

Could we rename svc_close_net() to svc_shutdown_net() and drop this
function?=20
Either way:=20
  Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown
