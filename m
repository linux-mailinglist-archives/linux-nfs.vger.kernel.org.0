Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713F45B1B1A
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 13:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIHLPl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 07:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiIHLPc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 07:15:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398B8979EF
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 04:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A445B820BB
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 11:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9E4C433D7;
        Thu,  8 Sep 2022 11:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662635727;
        bh=6q/aeNNL2BUnErB9MY6//4EqY5phmVdgGXK2cn2oZig=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lzw31StQWeVvZtpFwkmvbOrvI0bWeFOe0D9dQGbVRrnsU24TNUuuWdnWJJq1G6DxG
         Oo19ak+RcKPh8GYBsrwuk/BUAbT+unkaSgwzEUaXyPtBGD6SH/jEV8KzAC7zqp97aX
         pJm1ieqROlnc/OipGsRlRYKwCgTIAoFE/96+kbGrAN4FgwTvnyUjiP5uVmwUUdfOrz
         UT/c054CYZ3f53os8evUdbviAkArdqrPAhx/ZKrALiH9cZQV0RWEJCa8mFGLthBmuK
         tKJfISxG60xm8d4lpAJqHZwmY/Ycf10spy5PVLHHXd1hMWYqmmxCdugPFrgogQZJyr
         eNO3am4ohrB9g==
Message-ID: <d2150b0c17ace9fee06f75a4215f08e187227065.camel@kernel.org>
Subject: Re: [PATCH] NFSD: fix regression with setting ACLs.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 08 Sep 2022 07:15:25 -0400
In-Reply-To: <166260292002.30452.4279820246560338475@noble.neil.brown.name>
References: <166260292002.30452.4279820246560338475@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
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

On Thu, 2022-09-08 at 12:08 +1000, NeilBrown wrote:
> A recent patch moved ACL setting into nfsd_setattr().
> Unfortunately it didn't work as nfsd_setattr() aborts early if
> iap->ia_valid is 0.
>=20
> Remove this test, and instead avoid calling notify_change() when
> ia_valid is 0.
>=20
> This means that nfsd_setattr() will now *always* lock the inode.
> Previously it didn't if only a ATTR_MODE change was requested on a
> symlink (see Commit 15b7a1b86d66 ("[PATCH] knfsd: fix setattr-on-symlink
> error return")). I don't think this change really matters.
>=20
> Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/vfs.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 9f486b788ed0..bffb31540df8 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -353,7 +353,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
>  	int		accmode =3D NFSD_MAY_SATTR;
>  	umode_t		ftype =3D 0;
>  	__be32		err;
> -	int		host_err;
> +	int		host_err =3D 0;
>  	bool		get_write_count;
>  	bool		size_change =3D (iap->ia_valid & ATTR_SIZE);
> =20
> @@ -395,9 +395,6 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
>  	if (S_ISLNK(inode->i_mode))
>  		iap->ia_valid &=3D ~ATTR_MODE;
> =20
> -	if (!iap->ia_valid)
> -		return 0;
> -
>  	nfsd_sanitize_attrs(inode, iap);
> =20
>  	if (check_guard && guardtime !=3D inode->i_ctime.tv_sec)
> @@ -448,8 +445,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
>  			goto out_unlock;
>  	}
> =20
> -	iap->ia_valid |=3D ATTR_CTIME;
> -	host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
> +	if (iap->ia_valid) {
> +		iap->ia_valid |=3D ATTR_CTIME;
> +		host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
> +	}
> =20
>  out_unlock:
>  	if (attr->na_seclabel && attr->na_seclabel->len)

Looks sane.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
