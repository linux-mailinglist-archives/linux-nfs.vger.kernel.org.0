Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA16F4992
	for <lists+linux-nfs@lfdr.de>; Tue,  2 May 2023 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbjEBSQ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 May 2023 14:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjEBSQ5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 May 2023 14:16:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C458DE46;
        Tue,  2 May 2023 11:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49A6362303;
        Tue,  2 May 2023 18:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12004C4339B;
        Tue,  2 May 2023 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683051412;
        bh=7N/SYJ24XOx8sXvrK8L1jSX1KXOlwXFskV61Q2kqZXo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FGlJtGbUXA7HWKK48AGAOqdME8xjcRP9rxg5nKKdBesVlvepOqjjeRj+m65N379b/
         TF2/+K7czBhAhejL9B8q0PpOWPE3Jv5Nk9S0Wa4L6GuTlYq4Q+X61SwJ5IMMEBewzs
         bRzbrDvg9VTN9xGCYQCmKZEBEQsaRwaiNyCZ0YJ5J1KdHrrAMtsIzt5QDRc1SIKEEU
         /QaE90CLC7lvFzJmuTp3093KdQxzEqF/XFeKYI+1dQr5kGuoP04dk0CDe2i4+V1NRk
         XdlJDzJIsRkNDBu+8xNIYJCSp/ZJq+U5vpOAnwrHppfGKbagifllN2DJ2UUOZJsLwz
         Alse+Z3GoghiQ==
Message-ID: <f1b5a29c393e2f6b23420bfc94beceff1be69ae7.camel@kernel.org>
Subject: Re: [PATCH] lockd: define nlm_port_min,max with CONFIG_SYSCTL
From:   Jeff Layton <jlayton@kernel.org>
To:     Tom Rix <trix@redhat.com>, chuck.lever@oracle.com,
        trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 02 May 2023 14:16:50 -0400
In-Reply-To: <20230502180713.2930022-1-trix@redhat.com>
References: <20230502180713.2930022-1-trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-05-02 at 14:07 -0400, Tom Rix wrote:
> gcc with W=3D1 and ! CONFIG_SYSCTL
> fs/lockd/svc.c:80:51: error: =E2=80=98nlm_port_max=E2=80=99 defined but n=
ot used [-Werror=3Dunused-const-variable=3D]
>    80 | static const int                nlm_port_min =3D 0, nlm_port_max =
=3D 65535;
>       |                                                   ^~~~~~~~~~~~
> fs/lockd/svc.c:80:33: error: =E2=80=98nlm_port_min=E2=80=99 defined but n=
ot used [-Werror=3Dunused-const-variable=3D]
>    80 | static const int                nlm_port_min =3D 0, nlm_port_max =
=3D 65535;
>       |                                 ^~~~~~~~~~~~
>=20
> The only use of these variables is when CONFIG_SYSCTL
> is defined, so their definition should be likewise conditional.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  fs/lockd/svc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index bb94949bc223..04ba95b83d16 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -77,9 +77,9 @@ static const unsigned long	nlm_grace_period_min =3D 0;
>  static const unsigned long	nlm_grace_period_max =3D 240;
>  static const unsigned long	nlm_timeout_min =3D 3;
>  static const unsigned long	nlm_timeout_max =3D 20;
> -static const int		nlm_port_min =3D 0, nlm_port_max =3D 65535;
> =20
>  #ifdef CONFIG_SYSCTL
> +static const int		nlm_port_min =3D 0, nlm_port_max =3D 65535;
>  static struct ctl_table_header * nlm_sysctl_table;
>  #endif
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
