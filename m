Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E962C6B04EF
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Mar 2023 11:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCHKs1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Mar 2023 05:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCHKsN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Mar 2023 05:48:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E52ECDCA
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 02:48:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEA166173B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 10:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39764C433D2;
        Wed,  8 Mar 2023 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678272491;
        bh=jnzFIHLZoWHleZv2AGVvvRRyjsFUTN2szE9kmzvNrvA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MYeC14pDEUdeBjDNg20ED2oJf008iCQoXkSzzSW0FyC+9InxWghVnyH6DUmdRHcSn
         mPDFY5bYVr1RZluxV84y+oAVxjhW7g0xX+ik3P9ZpCGam1tCgEnBJWsgcBU+pXCIX6
         fYSTKTmGMnKx/1XnhkICs7LgGgCbqC4JX1DTO/Extb9wQ1Z977eyjjoXbG6u6ZlPGe
         zgvygRDzDzBpxeFBLhWCS9bsAmXPdI9wXoLpYv6QF836yUZwy2R4/uxY5XZvqUCRvY
         SXaT/PYdDYVoeL8nCoeSlv9KfQOC7JXmNOxCv0kcnkdsVea/0FLWXby+gL3dv5r2Gu
         0Nx95FtLyRo3g==
Message-ID: <b9aebe4951bb7af4fa07dbdacd2f1751944f7cf2.camel@kernel.org>
Subject: Re: [PATCH 1/1] SUNRPC: Fix a server shutdown leak
From:   Jeff Layton <jlayton@kernel.org>
To:     Benjamin Coddington <bcodding@redhat.com>, chuck.lever@oracle.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Mar 2023 05:48:08 -0500
In-Reply-To: <65d0248533fbdea2f6190faa1ee150d2d615344b.1677877233.git.bcodding@redhat.com>
References: <cover.1677877233.git.bcodding@redhat.com>
         <65d0248533fbdea2f6190faa1ee150d2d615344b.1677877233.git.bcodding@redhat.com>
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

On Fri, 2023-03-03 at 16:08 -0500, Benjamin Coddington wrote:
> Fix a race where kthread_stop() may prevent the threadfn from ever gettin=
g
> called.  If that happens the svc_rqst will not be cleaned up.
>=20
> Fixes: ed6473ddc704 ("NFSv4: Fix callback server shutdown")
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  net/sunrpc/svc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 1fd3f5e57285..fea7ce8fba14 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -798,6 +798,7 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_=
pool *pool, int nrservs)
>  static int
>  svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrse=
rvs)
>  {
> +	struct svc_rqst	*rqstp;
>  	struct task_struct *task;
>  	unsigned int state =3D serv->sv_nrthreads-1;
> =20
> @@ -806,7 +807,10 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_=
pool *pool, int nrservs)
>  		task =3D choose_victim(serv, pool, &state);
>  		if (task =3D=3D NULL)
>  			break;
> -		kthread_stop(task);
> +		rqstp =3D kthread_data(task);
> +		/* Did we lose a race to svo_function threadfn? */
> +		if (kthread_stop(task) =3D=3D -EINTR)
> +			svc_exit_thread(rqstp);
>  		nrservs++;
>  	} while (nrservs < 0);
>  	return 0;

Reviewed-by: Jeff Layton <jlayton@kernel.org>
