Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D659776FE42
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 12:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjHDKQA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 06:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjHDKP3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 06:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D2049DA;
        Fri,  4 Aug 2023 03:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7869E61F93;
        Fri,  4 Aug 2023 10:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72970C433C9;
        Fri,  4 Aug 2023 10:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691144085;
        bh=5AbSMMDb611We4H8Uqf50UdR5/vu5K+47HcJ7iRObW4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pF7bqoESmf4ecbWV81PJn8imMt4V+BWKXh8PJTBVpPQYPDJivBcY0d/8XXPTW4bSs
         ZpNzwdHq0W0/EHFRqrRYE7U4WVxCfdWYv931rVIIpzDRbEg6BzvHnTIHFm80hVRhvf
         h28iNhNnyR/Bb8qX6wUoyZyjXK7ZaGRx/lCpzGHsSbLhZz/U1i/be7Zr397zFjeiIw
         f5kxIpC5ZDdvpZc8kr38S6zONMPTBt998z/PEM5axUQoHZMbz4pbQVUO+iphrr8Jc4
         GO6uqR02C1utDNxNThyTIgQdJWuYcpJH2maYVAhXOmoTy8cmI9Qq91cdezNhzYpGBy
         LNaKeq4QBN8Rw==
Message-ID: <85f0d8cb35c8e8c64810f448bae27292703d66ed.camel@kernel.org>
Subject: Re: [PATCH v2] fs: lockd: avoid possible wrong NULL parameter
From:   Jeff Layton <jlayton@kernel.org>
To:     Su Hui <suhui@nfschina.com>, trond.myklebust@hammerspace.com,
        anna@kernel.org, chuck.lever@oracle.com, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com
Cc:     bfields@fieldses.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Date:   Fri, 04 Aug 2023 06:14:43 -0400
In-Reply-To: <20230804012656.4091877-1-suhui@nfschina.com>
References: <20230804012656.4091877-1-suhui@nfschina.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-08-04 at 09:26 +0800, Su Hui wrote:
> clang's static analysis warning: fs/lockd/mon.c: line 293, column 2:
> Null pointer passed as 2nd argument to memory copy function.
>=20
> Assuming 'hostname' is NULL and calling 'nsm_create_handle()', this will
> pass NULL as 2nd argument to memory copy function 'memcpy()'. So return
> NULL if 'hostname' is invalid.
>=20
> Fixes: 77a3ef33e2de ("NSM: More clean up of nsm_get_handle()")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> v2:
>  - move NULL check to the callee "nsm_create_handle()"
>  fs/lockd/mon.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/lockd/mon.c b/fs/lockd/mon.c
> index 1d9488cf0534..87a0f207df0b 100644
> --- a/fs/lockd/mon.c
> +++ b/fs/lockd/mon.c
> @@ -276,6 +276,9 @@ static struct nsm_handle *nsm_create_handle(const str=
uct sockaddr *sap,
>  {
>  	struct nsm_handle *new;
> =20
> +	if (!hostname)
> +		return NULL;
> +
>  	new =3D kzalloc(sizeof(*new) + hostname_len + 1, GFP_KERNEL);
>  	if (unlikely(new =3D=3D NULL))
>  		return NULL;

Reviewed-by: Jeff Layton <jlayton@kernel.org>
