Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85659750464
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jul 2023 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjGLK2P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jul 2023 06:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLK2O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jul 2023 06:28:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2A211B
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jul 2023 03:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD43661713
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jul 2023 10:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B711C433C8;
        Wed, 12 Jul 2023 10:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689157692;
        bh=oQlkjIo7H+tZ3xk0sqmoRP6tmOypxWcNLa41lRtM1Hk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=f2qYoPngKZpU/Vy7qpJKQDjAeFQdDCQg4HKfYzgHmYV/HBODtm4eoUbt60gL+MyjQ
         2Fq+fvrMD6jcZylIpRx1rFrt6okXYDgQb2st9/wrZj80cdV6zn+iolwRv2YC6+RxrJ
         fihjnEbdj6MIp+jPnBxMoVebpnrQE5zh/YtEgsBDs+rR+hkxjHRxw8Wuldm9FGb6HS
         49GadWj/MzzxBGeO10j1us7CdYa0zneJsRVUAdlogJ/QJq7OYgeOQrdfQ6PRLwFECm
         XVvddbPjKa/dQOxw1JjO0hfQkGlRHULhnKWBmgI8wvB/x98LnW7oUwM5UHV/gYh5xF
         ugC++rQ5SVHeg==
Message-ID: <e4d22ae6cefb34463ed7d04287ca9e81cd0949d8.camel@kernel.org>
Subject: Re: [PATCH 1/1] runtest/net.nfs: Run nfs02_06 on TCP only
From:   Jeff Layton <jlayton@kernel.org>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Wed, 12 Jul 2023 06:28:10 -0400
In-Reply-To: <20230622084648.490498-1-pvorel@suse.cz>
References: <20230622084648.490498-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-06-22 at 10:46 +0200, Petr Vorel wrote:
> UDP support disabled was on NFS server in kernel 5.6.
> Due that 2 of 3 nfs06.sh tests runs are being skipped on newer kernels.
>=20
> Therefore NFSv3 job in nfs02_06 test as TCP. This way all jobs in the
> test are TCP, thus test will not be skipped. This also bring NFSv3
> testing also under TCP (previously it was tested only on UDP).
>=20
> Keep UDP in nfs01_06 jobs, so that NFSv3 on UDP is still covered for
> older kernels.
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/net.nfs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/runtest/net.nfs b/runtest/net.nfs
> index 72cf4b307..15a960017 100644
> --- a/runtest/net.nfs
> +++ b/runtest/net.nfs
> @@ -58,7 +58,7 @@ nfs41_ipv6_05 nfs05.sh -6 -v 4.1 -t tcp
>  nfs42_ipv6_05 nfs05.sh -6 -v 4.2 -t tcp
> =20
>  nfs01_06  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
> -nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "udp,tcp,tcp,tcp,tcp,tcp"
> +nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
>  nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp=
,tcp,tcp"
> =20
>  nfs3_07 nfs07.sh -v 3 -t udp

UDP support is more or less being deprecated at this point, so testing
on tcp is preferred.

Acked-by: Jeff Layton <jlayton@kernel.org>
