Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D416E7732
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Apr 2023 12:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjDSKHg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Apr 2023 06:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjDSKHH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Apr 2023 06:07:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9BB1FFE
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 03:06:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19561634D8
        for <linux-nfs@vger.kernel.org>; Wed, 19 Apr 2023 10:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10725C433EF;
        Wed, 19 Apr 2023 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681898818;
        bh=5T36YIrnDu7GCxTizeamoEF539DOquiMYXtWMd9fUt0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mpfTMbvy+qYEu4BVNVCJNn5YvQSCrtxH/6H6ld71UzCa1GMlgPiI8cLfNiolgwFoJ
         Oy4GZlfkQhM2Yvo2fs4WyMCatSZC3VMoa4RZ3PG/4Kgh72EHEN0HsiYIS2Q7U/fk9M
         SF4NBe/UYGi2XE6/7qDA/7rY3sQGKgtYDgwDSi4yHIxJAL3KChWv+lKtJBxjB6ISJC
         qocU7RFAJl/ztdkzWxkqDSkqFx2Ev+C+VVomhEdQZTvo6RQM+MR72oZ+6iSW81ZaRY
         P2axucxlkK0JoYFLfWoCB1eLNBymoG9XvPut1tzt1R0qWTMQiErWbVvU9qQqkESEGe
         t3nfUY5aBCX6Q==
Message-ID: <63ccdf13db934fdbca46233b6dd961f54d47c6e8.camel@kernel.org>
Subject: Re: [PATCH] SUNRPC: remove the maximum number of retries in
 call_bind_status
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, trondmy@hammerspace.com,
        anna@kernel.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 19 Apr 2023 06:06:56 -0400
In-Reply-To: <1681849142-28597-1-git-send-email-dai.ngo@oracle.com>
References: <1681849142-28597-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-04-18 at 13:19 -0700, Dai Ngo wrote:
> Currently call_bind_status places a hard limit of 3 to the number of
> retries on EACCES error. This limit was done to prevent NLM unlock
> requests from being hang forever when the server keeps returning garbage.
> However this change causes problem for cases when NLM service takes
> longer than 9 seconds to register with the port mapper after a restart.
>=20
> This patch removes this hard coded limit and let the RPC handles
> the retry based on the standard hard/soft task semantics.
>=20
> Fixes: 0b760113a3a1 ("NLM: Don't hang forever on NLM unlock requests")
> Reported-by: Helen Chao <helen.chao@oracle.com>
> Tested-by: Helen Chao <helen.chao@oracle.com>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  include/linux/sunrpc/sched.h | 3 +--
>  net/sunrpc/clnt.c            | 3 ---
>  net/sunrpc/sched.c           | 1 -
>  3 files changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
> index b8ca3ecaf8d7..8ada7dc802d3 100644
> --- a/include/linux/sunrpc/sched.h
> +++ b/include/linux/sunrpc/sched.h
> @@ -90,8 +90,7 @@ struct rpc_task {
>  #endif
>  	unsigned char		tk_priority : 2,/* Task priority */
>  				tk_garb_retry : 2,
> -				tk_cred_retry : 2,
> -				tk_rebind_retry : 2;
> +				tk_cred_retry : 2;
>  };
> =20
>  typedef void			(*rpc_action)(struct rpc_task *);
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 0b0b9f1eed46..63b438d8564b 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2050,9 +2050,6 @@ call_bind_status(struct rpc_task *task)
>  			status =3D -EOPNOTSUPP;
>  			break;
>  		}
> -		if (task->tk_rebind_retry =3D=3D 0)
> -			break;
> -		task->tk_rebind_retry--;
>  		rpc_delay(task, 3*HZ);
>  		goto retry_timeout;
>  	case -ENOBUFS:
> diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
> index be587a308e05..c8321de341ee 100644
> --- a/net/sunrpc/sched.c
> +++ b/net/sunrpc/sched.c
> @@ -817,7 +817,6 @@ rpc_init_task_statistics(struct rpc_task *task)
>  	/* Initialize retry counters */
>  	task->tk_garb_retry =3D 2;
>  	task->tk_cred_retry =3D 2;
> -	task->tk_rebind_retry =3D 2;
> =20
>  	/* starting timestamp */
>  	task->tk_start =3D ktime_get();


Reviewed-by: Jeff Layton <jlayton@kernel.org>
