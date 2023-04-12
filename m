Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052B46DFCF8
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Apr 2023 19:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjDLRu5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Apr 2023 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDLRu4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Apr 2023 13:50:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618659E
        for <linux-nfs@vger.kernel.org>; Wed, 12 Apr 2023 10:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9ACE632DF
        for <linux-nfs@vger.kernel.org>; Wed, 12 Apr 2023 17:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A40C433D2;
        Wed, 12 Apr 2023 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681321854;
        bh=rRvT977+3NWauiKI82rT0SwKVFALtRpiJKS6dWmvKfA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kitdv51mAGD9ZHrgErGRptf1WEjopPVHv8piAg/8VWWPVDbLiizYTTIMFfklZ9zMZ
         0js9pexgXQTWOM1JLwle7nP9n7vphpesAKDSsWyaDeHRVGv+yJZHztXPconUTzBKA1
         al4f1IZGrU9J8FiNepXS6wxhCfEzqUTQo67DxmfYggfs5GZhgf2JjIL138McWjTCA6
         W6wJHgm7Zj9KKpKu8FBTDZInuY2rlpDjO44w13bXyakXAvxQgHlD07Oq8YBosZL7Pd
         GY/B8/HlNiJadV3W6HYFLuRtkAvqyqAwj8oRmQjJ9SUPBfvd7x7NK79WuafEqCD7T9
         C3Te5/WAfjHKw==
Message-ID: <9b97325926ccb7d983455b13617a35c9e83dd7be.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: increase max timeout for rebind to handle NFS
 server restart
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 12 Apr 2023 13:50:52 -0400
In-Reply-To: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
References: <1680924600-11171-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-04-07 at 20:30 -0700, Dai Ngo wrote:
> Currently call_bind_status places a hard limit of 9 seconds for retries
> on EACCES error. This limit was done to prevent the RPC request from
> being retried forever if the remote server has problem and never comes
> up
>=20
> However this 9 seconds timeout is too short, comparing to other RPC
> timeouts which are generally in minutes. This causes intermittent failure
> with EIO on the client side when there are lots of NLM activity and the
> NFS server is restarted.
>=20
> Instead of removing the max timeout for retry and relying on the RPC
> timeout mechanism to handle the retry, which can lead to the RPC being
> retried forever if the remote NLM service fails to come up. This patch
> simply increases the max timeout of call_bind_status from 9 to 90 seconds
> which should allow enough time for NLM to register after a restart, and
> not retrying forever if there is real problem with the remote system.
>=20
> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
> Reported-by: Helen Chao <helen.chao@oracle.com>
> Tested-by: Helen Chao <helen.chao@oracle.com>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  include/linux/sunrpc/clnt.h  | 3 +++
>  include/linux/sunrpc/sched.h | 4 ++--
>  net/sunrpc/clnt.c            | 2 +-
>  net/sunrpc/sched.c           | 3 ++-
>  4 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
> index 770ef2cb5775..81afc5ea2665 100644
> --- a/include/linux/sunrpc/clnt.h
> +++ b/include/linux/sunrpc/clnt.h
> @@ -162,6 +162,9 @@ struct rpc_add_xprt_test {
>  #define RPC_CLNT_CREATE_REUSEPORT	(1UL << 11)
>  #define RPC_CLNT_CREATE_CONNECTED	(1UL << 12)
> =20
> +#define	RPC_CLNT_REBIND_DELAY		3
> +#define	RPC_CLNT_REBIND_MAX_TIMEOUT	90
> +
>  struct rpc_clnt *rpc_create(struct rpc_create_args *args);
>  struct rpc_clnt	*rpc_bind_new_program(struct rpc_clnt *,
>  				const struct rpc_program *, u32);
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index b8ca3ecaf8d7..e9dc142f10bb 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -90,8 +90,8 @@ struct rpc_task {
>  #endif
>  	unsigned char		tk_priority : 2,/* Task priority */
>  				tk_garb_retry : 2,
> -				tk_cred_retry : 2,
> -				tk_rebind_retry : 2;
> +				tk_cred_retry : 2;
> +	unsigned char		tk_rebind_retry;
>  };
> =20
>  typedef void			(*rpc_action)(struct rpc_task *);
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index fd7e1c630493..222578af6b01 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2053,7 +2053,7 @@ call_bind_status(struct rpc_task *task)
>  		if (task->tk_rebind_retry =3D=3D 0)
>  			break;
>  		task->tk_rebind_retry--;
> -		rpc_delay(task, 3*HZ);
> +		rpc_delay(task, RPC_CLNT_REBIND_DELAY * HZ);
>  		goto retry_timeout;
>  	case -ENOBUFS:
>  		rpc_delay(task, HZ >> 2);
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index be587a308e05..5c18a35752aa 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -817,7 +817,8 @@ rpc_init_task_statistics(struct rpc_task *task)
>  	/* Initialize retry counters */
>  	task->tk_garb_retry =3D 2;
>  	task->tk_cred_retry =3D 2;
> -	task->tk_rebind_retry =3D 2;
> +	task->tk_rebind_retry =3D RPC_CLNT_REBIND_MAX_TIMEOUT /
> +					RPC_CLNT_REBIND_DELAY;
> =20
>  	/* starting timestamp */
>  	task->tk_start =3D ktime_get();

Reviewed-by: Jeff Layton <jlayton@kernel.org>
