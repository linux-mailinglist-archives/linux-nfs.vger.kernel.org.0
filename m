Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023655FA885
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Oct 2022 01:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiJJXPo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Oct 2022 19:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJJXPm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Oct 2022 19:15:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B621260E;
        Mon, 10 Oct 2022 16:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 470BA60FDD;
        Mon, 10 Oct 2022 23:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD665C433D6;
        Mon, 10 Oct 2022 23:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665443738;
        bh=BUq1YPTumUZb0Wi+t/sy5T0ThJRytv0zmQM1BLf9I8o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ki2Ty2Dq7txvZOe0W5icww4T7PPTtTPuewa5qERa+YZ47XukQLT9E7SO5afxc79X7
         RY2TaDgzecamwdnHFf2QT6xC/MMbyDsINFixgUsZrKi/iQqxgDki4GS/FFWqD+SeK/
         BF+JeRB27n1vkC9A0XUBXQuBNofSvxATH+KXCDqv9c5cJJQd1nwvwUBNcLCiBOWgPd
         i83UQuIbMK1CbPP4fmYzLvEnlodbxUe8J+K8Hln/+nJwO9CCd8zFFtqZhOouD7pm8Y
         N60xftCRr4o1CqNK3bUulrlFNOibuX4R2D2dfwKnqQgCx8+wx9I2mENIm9suAVqjss
         Ep+agTKHAgKWw==
Message-ID: <9d31359e22601b7469b7df1feac20e33856ee6ae.camel@kernel.org>
Subject: Re: [PATCH] NFSD: Remove redundant assignment to variable host_err
From:   Jeff Layton <jlayton@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 10 Oct 2022 19:15:36 -0400
In-Reply-To: <20221010202423.3221664-1-colin.i.king@gmail.com>
References: <20221010202423.3221664-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-10 at 21:24 +0100, Colin Ian King wrote:
> Variable host_err is assigned a value that is never read, it is being
> re-assigned a value in every different execution path in the following
> switch statement. The assignment is redundant and can be removed.
>=20
> Cleans up clang-scan warning:
> warning: Value stored to 'host_err' is never read [deadcode.DeadStores]
>=20

The warning is a bit odd since it _is_ read at the bottom of the
function:

        err =3D nfserrno(host_err);                                    =20

...but, all of the switch cases end up setting host_err, so the
initialization isn't needed.

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/nfsd/vfs.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f650afedd67f..5093ae788f53 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1304,7 +1304,6 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  		iap->ia_mode &=3D ~current_umask();
> =20
>  	err =3D 0;
> -	host_err =3D 0;
>  	switch (type) {
>  	case S_IFREG:
>  		host_err =3D vfs_create(&init_user_ns, dirp, dchild, iap->ia_mode, tru=
e);

Reviewed-by: Jeff Layton <jlayton@kernel.org>
