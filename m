Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273927AB9F3
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 21:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjIVTTg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 15:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjIVTTf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 15:19:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2784A3
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 12:19:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFBAC433C7;
        Fri, 22 Sep 2023 19:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695410369;
        bh=dXOqTbOgPd5IRpEfDgGxOxnKP4GfARC7wgQHeofg7R4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Bz9EHguHUemOzgfTkyfX3KOJ7NZGGTw+quOWUWD9NyxIieG+vfX3KvLTLE+Lo4w42
         K1VtDADTIARyJxX4pifliDEXh/V5Y4IVyGSyzGCKh2BoiZ06h9K5a6/9ogrbYUrzh1
         2amJGf0oK3V1itkCmJBh9F3AZ60nTY8BhJMKLc9arzm7tI5EqeOB4TOF9jgJRtGdCT
         NB8GpIvQFkrINEVxoeAF+x0YfDzywfuas+ngbVv+P/3sMpFSiUQFdLn0fkZL31Ft4u
         uUpSKU5etjgDlQLzPrEAjXwAYbqr/fcBTWJB3e3Vm2Nsf+rZxW8zaJSEZpEixtMzKh
         IT5loXBqqXLCQ==
Message-ID: <ccac5c0333b60cb37309a15f18f8592c19d73879.camel@kernel.org>
Subject: Re: [PATCH v1] SUNRPC: Remove BUG_ON call sites
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, neilb@suse.de, brauner@kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Fri, 22 Sep 2023 15:19:27 -0400
In-Reply-To: <169504668787.134583.4338728458451666583.stgit@manet.1015granger.net>
References: <169504668787.134583.4338728458451666583.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-09-18 at 10:18 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> There is no need to take down the whole system for these assertions.
>=20
> I'd rather not attempt a heroic save here, as some bug has occurred
> that has left the transport data structures in an unknown state.
> Just warn and then leak the left-over resources.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/svc.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> Let's start here. Comments?
>=20
>=20
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 587811a002c9..11a1d5e7f5c7 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -575,11 +575,14 @@ svc_destroy(struct kref *ref)
>  	timer_shutdown_sync(&serv->sv_temptimer);
> =20
>  	/*
> -	 * The last user is gone and thus all sockets have to be destroyed to
> -	 * the point. Check this.
> +	 * Remaining transports at this point are not expected.
>  	 */
> -	BUG_ON(!list_empty(&serv->sv_permsocks));
> -	BUG_ON(!list_empty(&serv->sv_tempsocks));
> +	if (unlikely(!list_empty(&serv->sv_permsocks)))
> +		pr_warn("SVC: permsocks remain for %s\n",
> +			serv->sv_program->pg_name);
> +	if (unlikely(!list_empty(&serv->sv_tempsocks)))
> +		pr_warn("SVC: tempsocks remain for %s\n",
> +			serv->sv_program->pg_name);
> =20
>  	cache_clean_deferred(serv);
> =20
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
