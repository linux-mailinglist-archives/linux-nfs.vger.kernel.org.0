Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951E2578B23
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jul 2022 21:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiGRTpB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 Jul 2022 15:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbiGRTpA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 Jul 2022 15:45:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E1518B01
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 12:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 827E3B81681
        for <linux-nfs@vger.kernel.org>; Mon, 18 Jul 2022 19:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B27C341C0;
        Mon, 18 Jul 2022 19:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658173497;
        bh=vE0RaH3p6+AFcnG568snLTEAqj9SehBHZDo2OVO79uY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZFakyDwurfP9k8ayw2BwJgiacqVlhjW6ED7soTYo9loVwOVfNk9EF8A7O2jLxGqCd
         tFcXgOBAaLfjSrSOzgoTFlf7OD3aglRyXad9JpyTsXAkIjCR/5oo5G4arKfHZ931jT
         gI+Z7NS6yruN4vpRjm3vMGLWYqTBKY8+ausff4YDonicz4ncPw93omE101iusERoWs
         vfbfa4VW9Zg0z1r9P4By3e7xh1c1nhuMYzrXkfnQz5tTzrvcnOLs1P2R3XpszNUq7J
         XMPtoBS0dtgD2YMQpW4j5JIgzmsxL8kbFPMhJre7MOwxSA7DqvnH8CSxpCe3tKB53h
         MRU81micPBJSw==
Message-ID: <d9802f7f297170acd65d898211eb70843865380d.camel@kernel.org>
Subject: Re: [PATCH v2 07/15] SUNRPC: Refactor rpc_call_null_helper()
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Mon, 18 Jul 2022 15:44:55 -0400
In-Reply-To: <165452707392.1496.12861225717405665289.stgit@oracle-102.nfsv4.dev>
References: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
         <165452707392.1496.12861225717405665289.stgit@oracle-102.nfsv4.dev>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-06-06 at 10:51 -0400, Chuck Lever wrote:
> I'm about to add a use case that does not want RPC_TASK_NULLCREDS.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/clnt.c |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 0ca86c92968f..ade83ee13bac 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2751,8 +2751,7 @@ struct rpc_task *rpc_call_null_helper(struct rpc_cl=
nt *clnt,
>  		.rpc_op_cred =3D cred,
>  		.callback_ops =3D ops ?: &rpc_null_ops,
>  		.callback_data =3D data,
> -		.flags =3D flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN |
> -			 RPC_TASK_NULLCREDS,
> +		.flags =3D flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN,
>  	};
> =20
>  	return rpc_run_task(&task_setup_data);
> @@ -2760,7 +2759,8 @@ struct rpc_task *rpc_call_null_helper(struct rpc_cl=
nt *clnt,
> =20
>  struct rpc_task *rpc_call_null(struct rpc_clnt *clnt, struct rpc_cred *c=
red, int flags)
>  {
> -	return rpc_call_null_helper(clnt, NULL, cred, flags, NULL, NULL);
> +	return rpc_call_null_helper(clnt, NULL, cred, flags | RPC_TASK_NULLCRED=
S,
> +				    NULL, NULL);
>  }
>  EXPORT_SYMBOL_GPL(rpc_call_null);
> =20
> @@ -2860,9 +2860,11 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *cl=
nt,
>  		goto success;
>  	}
> =20
> -	task =3D rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_ASYNC,
> -			&rpc_cb_add_xprt_call_ops, data);
> +	task =3D rpc_call_null_helper(clnt, xprt, NULL,
> +				    RPC_TASK_ASYNC | RPC_TASK_NULLCREDS,
> +				    &rpc_cb_add_xprt_call_ops, data);
>  	data->xps->xps_nunique_destaddr_xprts++;
> +
>  	rpc_put_task(task);
>  success:
>  	return 1;
> @@ -2903,7 +2905,8 @@ int rpc_clnt_setup_test_and_add_xprt(struct rpc_cln=
t *clnt,
>  		goto out_err;
> =20
>  	/* Test the connection */
> -	task =3D rpc_call_null_helper(clnt, xprt, NULL, 0, NULL, NULL);
> +	task =3D rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_NULLCREDS,
> +				    NULL, NULL);
>  	if (IS_ERR(task)) {
>  		status =3D PTR_ERR(task);
>  		goto out_err;
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
