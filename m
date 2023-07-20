Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D8D75B883
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 22:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjGTUHd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 16:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGTUHc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 16:07:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481062118
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 13:07:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2483961C2F
        for <linux-nfs@vger.kernel.org>; Thu, 20 Jul 2023 20:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33324C433C8;
        Thu, 20 Jul 2023 20:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689883637;
        bh=9cbjuaC1u7U368dMWfKOA9d+Lwti1zuCypnCr21kfw0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VeAPCXnzy++/bK6/spvXlBfZgO48tYVEsa2zib0nQGs4/c8tgRSisEhyDvoLfj5Rg
         QKBTYqkG4ZlQjftWYCofnxscUTvUyI2wMNF29BwWA9wHo+Zdvsvpp7SiuLVDtw5tLT
         Yeo4gVmyVZdiHNz3Fa73R3hW+0Zob91VqpF6wbxrGEjC+JN5rzLj2dBBy/cxKkYYdN
         bNiyFdRaZg1CmiL7Bgmr53rVTuu0zRveT++GEsWUxtfiBoc2WGdFAPsfZsudpdnxuA
         MIjNlMMiRojzRLHeANXQXP2X7fbOrS7fgyF3utp5AJ7T4+Hy6cNGDd/CRjsXhzYn5G
         Egq/YgWuMjggw==
Message-ID: <80105dc67e90c5187ba24247a6ccf9454b44258f.camel@kernel.org>
Subject: Re: [PATCH 03/14] SUNRPC: call svc_process() from svc_recv().
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 20 Jul 2023 16:07:16 -0400
In-Reply-To: <168966228861.11075.6512110736168003985.stgit@noble.brown>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
         <168966228861.11075.6512110736168003985.stgit@noble.brown>
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
> All callers of svc_recv() go on to call svc_process() on success.
> Simplify callers by having svc_recv() do that for them.
>=20
> This loses one call to validate_process_creds() in nfsd.  That was
> debugging code added 14 years ago.  I don't think we need to keep it.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/lockd/svc.c        |    5 -----
>  fs/nfs/callback.c     |    1 -
>  fs/nfsd/nfssvc.c      |    2 --
>  net/sunrpc/svc_xprt.c |    3 ++-
>  4 files changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 614faa5f69cd..91ef139a7757 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -132,7 +132,6 @@ lockd(void *vrqstp)
>  	 */
>  	while (!kthread_should_stop()) {
>  		long timeout =3D MAX_SCHEDULE_TIMEOUT;
> -		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
> =20
>  		/* update sv_maxconn if it has changed */
>  		rqstp->rq_server->sv_maxconn =3D nlm_max_connections;
> @@ -146,10 +145,6 @@ lockd(void *vrqstp)
>  		err =3D svc_recv(rqstp, timeout);
>  		if (err =3D=3D -EAGAIN || err =3D=3D -EINTR)
>  			continue;
> -		dprintk("lockd: request from %s\n",
> -				svc_print_addr(rqstp, buf, sizeof(buf)));
> -
> -		svc_process(rqstp);
>  	}
>  	if (nlmsvc_ops)
>  		nlmsvc_invalidate_all();
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 46a0a2d6962e..2d94384bd6a9 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -86,7 +86,6 @@ nfs4_callback_svc(void *vrqstp)
>  		err =3D svc_recv(rqstp, MAX_SCHEDULE_TIMEOUT);
>  		if (err =3D=3D -EAGAIN || err =3D=3D -EINTR)
>  			continue;
> -		svc_process(rqstp);
>  	}
> =20
>  	svc_exit_thread(rqstp);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 439fca195925..3e08cc746870 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -985,8 +985,6 @@ nfsd(void *vrqstp)
>  		if (err =3D=3D -EINTR)
>  			break;
>  		validate_process_creds();
> -		svc_process(rqstp);
> -		validate_process_creds();
>  	}
> =20
>  	atomic_dec(&nfsdstats.th_cnt);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 93395606a0ba..c808f6d60c99 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -895,7 +895,8 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
>  		serv->sv_stats->netcnt++;
>  	percpu_counter_inc(&rqstp->rq_pool->sp_messages_arrived);
>  	rqstp->rq_stime =3D ktime_get();
> -	return len;
> +	svc_process(rqstp);
> +	return 0;
>  out_release:
>  	rqstp->rq_res.len =3D 0;
>  	svc_xprt_release(rqstp);
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
