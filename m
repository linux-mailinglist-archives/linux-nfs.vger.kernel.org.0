Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC35C7BFAD8
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Oct 2023 14:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjJJMKR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Oct 2023 08:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjJJMKQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Oct 2023 08:10:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B9494
        for <linux-nfs@vger.kernel.org>; Tue, 10 Oct 2023 05:10:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDFFC433C7;
        Tue, 10 Oct 2023 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939814;
        bh=BhvqaimQ+dMrJmv0i50mvyKBawex152Ep4BJI8h8gz8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RfyEPY4tK7SwmNDMD1p7Ya6FdvnoRkoI5gv07DoIJL2PDqvjAGjq3hAca8KpykcwD
         SQKOc7R8MOHL+ANXcdXedqZxB4wum++C1kydFbQ0PFB8aZh14WE5jgXL4koZ4WiZou
         ub9Gm+jzLfuwYWSVeMe8YTuKpD9Hr10qgaouJu20GBLnCgr1WdPwnAG/Q0RKAJhVOa
         IZEU/orMRlbmiL9UzRbapYzh7GM4UQEaigtd1sAWpijcBg4ctzI6i2TX2Vd0XdRLEw
         hnFchG8euFVUKdmP9s1hPIo7euynj3lY0qB1H/z+N2FHbfM9U4Y4yggtm/Nm3M35Am
         i6LipqH7gVgmg==
Message-ID: <4cc5b614a2b8c4bae3aa1fe271f6915bd538ba22.camel@kernel.org>
Subject: Re: [PATCH] lockd: hold a reference to nlmsvc_serv while stopping
 thread.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Tue, 10 Oct 2023 08:10:12 -0400
In-Reply-To: <169689454310.26263.15848180396022999880@noble.neil.brown.name>
References: <169689454310.26263.15848180396022999880@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-10-10 at 10:35 +1100, NeilBrown wrote:
> We are required to hold a reference to the svc_serv struct while
> stopping the last thread, as doing that could otherwise drop the last
> reference itself and the svc_serv would be freed while still in use.
>=20
> lockd doesn't do this.  After startup, the only reference is held by the
> running thread.
>=20
> So change locked to hold a reference on nlmsvc_serv while-ever the
> service is active, and only drop it after the last thread has been
> stopped.
>=20
> Note: it doesn't really make sense for threads to hold references to the
> svc_serv any more.  The fact threads are included in serv->sv_nrthreads
> is sufficient.  Maybe a future patch could address this.
>=20
> Reported-by: Jeff Layton <jlayton@kernel.org>
> Fixes: 68cc388c3238 ("SUNRPC: change how svc threads are asked to exit.")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>=20
> Thanks for the report Jeff !!!
>=20
>  fs/lockd/svc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index b441c706c2b8..7a5c90a00522 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -345,10 +345,10 @@ static int lockd_get(void)
> =20
>  	serv->sv_maxconn =3D nlm_max_connections;
>  	error =3D svc_set_num_threads(serv, NULL, 1);
> -	/* The thread now holds the only reference */
> -	svc_put(serv);
> -	if (error < 0)
> +	if (error < 0) {
> +		svc_put(serv);
>  		return error;
> +	}
> =20
>  	nlmsvc_serv =3D serv;
>  	register_inetaddr_notifier(&lockd_inetaddr_notifier);
> @@ -374,6 +374,7 @@ static void lockd_put(void)
> =20
>  	svc_set_num_threads(nlmsvc_serv, NULL, 0);
>  	timer_delete_sync(&nlmsvc_retry);
> +	svc_put(nlmsvc_serv);
>  	nlmsvc_serv =3D NULL;
>  	dprintk("lockd_down: service destroyed\n");
>  }

Thanks Neil! You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
