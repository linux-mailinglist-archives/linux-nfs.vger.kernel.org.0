Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C8075B879
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 22:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGTUFG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 16:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGTUFF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 16:05:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFD21BE2
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 13:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 630F661C28
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 20:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52452C433C7;
        Thu, 20 Jul 2023 20:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689883503;
        bh=TPlyUgiLlIZgtFq0SKa6WJUz9g0jWLjo1Upm7/zlZFE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pyLx2b9XX7Qc0ZkrSGImZk3ihH+roS8zjv/w1jsMkiQxJU+pkmHc/7LW35uYtZRbh
         7S6JT4ASOyVgGSeb8ZVfF5wOEltQw1Ccxz0PyPcFaaH9w1DYoR+Zf71OEkwLQPDJFi
         t4B8FmDf2qD7ElH9K4DOmlAcrzsF+6PY96mkCOe4/nnfK0/+4oiGZq1thTpKDkJUzW
         ZXBfvNCS+HtvJw7IwxIAdNpbhVo6X7/meWSQfYKDstdUGdMcRfiYceOm/uNFuF9zCD
         OnruvqVDzTQuu0pjjJ50HMPY5M7boUacSKSlqT/+gDsmh+8jsxSxN+AgZq9FDrFOSP
         ftvlwnUTUiViA==
Message-ID: <b58d657859e5a05e73c6c92fa258e525ff199466.camel@kernel.org>
Subject: Re: [PATCH 01/14] lockd: remove SIGKILL handling.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 20 Jul 2023 16:05:02 -0400
In-Reply-To: <168966228859.11075.13570585046156408745.stgit@noble.brown>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
         <168966228859.11075.13570585046156408745.stgit@noble.brown>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-07-18 at 16:38 +1000, NeilBrown wrote:
> lockd allows SIGKILL and responds by dropping all locks and restarting
> the grace period.  This functionality has been present since 2.1.32 when
> lockd was added to Linux.
>=20
> This functionality is undocumented and most liked added as a useful
> debug aid.  When there is a need to drop locks, the best approach is
> using /proc/fs/nfsd/unlock_*.
>=20
> This patch removes the handling of SIGKILL as part of preparation for
> removing all signal handling from sunrpc service threads.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/lockd/svc.c |   24 ------------------------
>  1 file changed, 24 deletions(-)
>=20
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 22d3ff3818f5..614faa5f69cd 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -45,7 +45,6 @@
> =20
>  #define NLMDBG_FACILITY		NLMDBG_SVC
>  #define LOCKD_BUFSIZE		(1024 + NLMSVC_XDRSIZE)
> -#define ALLOWED_SIGS		(sigmask(SIGKILL))
> =20
>  static struct svc_program	nlmsvc_program;
> =20
> @@ -111,19 +110,6 @@ static void set_grace_period(struct net *net)
>  	schedule_delayed_work(&ln->grace_period_end, grace_period);
>  }
> =20
> -static void restart_grace(void)
> -{
> -	if (nlmsvc_ops) {
> -		struct net *net =3D &init_net;
> -		struct lockd_net *ln =3D net_generic(net, lockd_net_id);
> -
> -		cancel_delayed_work_sync(&ln->grace_period_end);
> -		locks_end_grace(&ln->lockd_manager);
> -		nlmsvc_invalidate_all();
> -		set_grace_period(net);
> -	}
> -}
> -
>  /*
>   * This is the lockd kernel thread
>   */
> @@ -138,9 +124,6 @@ lockd(void *vrqstp)
>  	/* try_to_freeze() is called from svc_recv() */
>  	set_freezable();
> =20
> -	/* Allow SIGKILL to tell lockd to drop all of its locks */
> -	allow_signal(SIGKILL);
> -
>  	dprintk("NFS locking service started (ver " LOCKD_VERSION ").\n");
> =20
>  	/*
> @@ -154,12 +137,6 @@ lockd(void *vrqstp)
>  		/* update sv_maxconn if it has changed */
>  		rqstp->rq_server->sv_maxconn =3D nlm_max_connections;
> =20
> -		if (signalled()) {
> -			flush_signals(current);
> -			restart_grace();
> -			continue;
> -		}
> -
>  		timeout =3D nlmsvc_retry_blocked();
> =20
>  		/*
> @@ -174,7 +151,6 @@ lockd(void *vrqstp)
> =20
>  		svc_process(rqstp);
>  	}
> -	flush_signals(current);
>  	if (nlmsvc_ops)
>  		nlmsvc_invalidate_all();
>  	nlm_shutdown_hosts();
>=20
>=20

Nice to finally do this!

Reviewed-by: Jeff Layton <jlayton@kernel.org>
