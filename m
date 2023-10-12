Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173637C6AB1
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Oct 2023 12:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbjJLKNh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Oct 2023 06:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbjJLKNg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Oct 2023 06:13:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D401BA;
        Thu, 12 Oct 2023 03:13:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A9DC433C8;
        Thu, 12 Oct 2023 10:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697105614;
        bh=xWColKJFPVRA7NvNebvl5hGQQh/jYw+XU8N3pViNLDs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LKiOGLNu4jAu2U0c0dMmIg6wu4Q05Ojxlo8zaukg8w4CSG5LWdN0HOxJHLijeHTWw
         h3BC5NG80mvzIbPiW1S3gwHMJ3aNZhaairnu00FDF7IgP8mSbj2BzZeFNRegsjuEX8
         GVUgyq6lRnP3diSdLfsfFGgoKvr1WLiKRt5LQ/CRJTn0PAqy79Pqyz/LslYWNEd0mo
         VfM2x3dqoDNLyb0sbKxwuRrG323vFZE18b8xkymu02IQ706z+hyrvpUrzo8yuRHkvK
         5gr9abvjCRSmBsjy00zszIVV/nRCUbpj9Iq77AceMWkso5nhZSUOPKC5qaEyNETDej
         qWD9x9khugy7A==
Message-ID: <5414753a03b924c5a5f5784783f4a530187be383.camel@kernel.org>
Subject: Re: [PATCH -next v2] sunrpc: Use no_printk() in dfprintk*() dummies
From:   Jeff Layton <jlayton@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 12 Oct 2023 06:13:32 -0400
In-Reply-To: <a93de2e8afa826745746b00fc5f64e513df5d52f.1697104757.git.geert+renesas@glider.be>
References: <a93de2e8afa826745746b00fc5f64e513df5d52f.1697104757.git.geert+renesas@glider.be>
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

On Thu, 2023-10-12 at 12:08 +0200, Geert Uytterhoeven wrote:
> When building NFS with W=3D1 and CONFIG_WERROR=3Dy, but
> CONFIG_SUNRPC_DEBUG=3Dn:
>=20
>     fs/nfs/nfs4proc.c: In function =E2=80=98nfs4_proc_create_session=E2=
=80=99:
>     fs/nfs/nfs4proc.c:9276:19: error: variable =E2=80=98ptr=E2=80=99 set =
but not used [-Werror=3Dunused-but-set-variable]
>      9276 |         unsigned *ptr;
> 	  |                   ^~~
>       CC      fs/nfs/callback.o
>     fs/nfs/callback.c: In function =E2=80=98nfs41_callback_svc=E2=80=99:
>     fs/nfs/callback.c:98:13: error: variable =E2=80=98error=E2=80=99 set =
but not used [-Werror=3Dunused-but-set-variable]
>        98 |         int error;
> 	  |             ^~~~~
>       CC      fs/nfs/flexfilelayout/flexfilelayout.o
>     fs/nfs/flexfilelayout/flexfilelayout.c: In function =E2=80=98ff_layou=
t_io_track_ds_error=E2=80=99:
>     fs/nfs/flexfilelayout/flexfilelayout.c:1230:13: error: variable =E2=
=80=98err=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable]
>      1230 |         int err;
> 	  |             ^~~
>       CC      fs/nfs/flexfilelayout/flexfilelayoutdev.o
>     fs/nfs/flexfilelayout/flexfilelayoutdev.c: In function =E2=80=98nfs4_=
ff_alloc_deviceid_node=E2=80=99:
>     fs/nfs/flexfilelayout/flexfilelayoutdev.c:55:16: error: variable =E2=
=80=98ret=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable]
>        55 |         int i, ret =3D -ENOMEM;
> 	  |                ^~~
>=20
> All these are due to variables that are set unconditionally, but are
> used only when debugging is enabled.
>=20
> Fix this by changing the dfprintk*() dummy macros from empty loops to
> calls to the no_printk() helper.  This informs the compiler that the
> passed debug parameters are actually used, and enables format specifier
> checking as a bonus.
>=20
> This requires removing the protection by CONFIG_SUNRPC_DEBUG of the
> declaration of nlmdbg_cookie2a(), as its reference is now visible to the
> compiler, but optimized away.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - s/uncontionally/unconditionally/,
>   - Drop CONFIG_SUNRPC_DEBUG check in fs/lockd/svclock.c to fix build
>     failure.
> ---
>  fs/lockd/svclock.c           | 2 --
>  include/linux/sunrpc/debug.h | 6 +++---
>  2 files changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 43aeba9de55cbbc5..119a0c31d30eed4f 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -55,7 +55,6 @@ static const struct rpc_call_ops nlmsvc_grant_ops;
>  static LIST_HEAD(nlm_blocked);
>  static DEFINE_SPINLOCK(nlm_blocked_lock);
> =20
> -#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
>  static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
>  {
>  	/*
> @@ -82,7 +81,6 @@ static const char *nlmdbg_cookie2a(const struct nlm_coo=
kie *cookie)
> =20
>  	return buf;
>  }
> -#endif
> =20
>  /*
>   * Insert a blocked lock into the global list
> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
> index f6aeed07fe04e3d5..76539c6673f2fb15 100644
> --- a/include/linux/sunrpc/debug.h
> +++ b/include/linux/sunrpc/debug.h
> @@ -67,9 +67,9 @@ do {									\
>  # define RPC_IFDEBUG(x)		x
>  #else
>  # define ifdebug(fac)		if (0)
> -# define dfprintk(fac, fmt, ...)	do {} while (0)
> -# define dfprintk_cont(fac, fmt, ...)	do {} while (0)
> -# define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
> +# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
> +# define dfprintk_cont(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
> +# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
>  # define RPC_IFDEBUG(x)
>  #endif
> =20

Acked-by: Jeff Layton <jlayton@kernel.org>
