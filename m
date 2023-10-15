Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718AF7C9B9C
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Oct 2023 22:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjJOUoV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Oct 2023 16:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjJOUoV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 15 Oct 2023 16:44:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F29AB
        for <linux-nfs@vger.kernel.org>; Sun, 15 Oct 2023 13:44:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF2DC433C7;
        Sun, 15 Oct 2023 20:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697402659;
        bh=EhY4qmnZXiEzTjmTY4xX8SjAcYitiaMfwDE0nmvDc1E=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Gd2IX0mMcdKe3A/8+FqKn7kLSE+l5B9u3aWvUk0HEdQ24aCELI/59yOV2nKhdVica
         SnzRCNtem3L/0YucxryouLgN7m3AoF/NQz0xPSFk2ziD4iY+/9lzgaGtL3ir5jjlw0
         zjEJs8KOO1R4PwVA7bPVVPCTO6BXtU5bSKXzY8VL9PGoo+JQbDN/BTUSLHKKywvcAl
         6CHKzWo5vbNIP8xL0EQcfLKi1rfgQ0F2izxR8ZmRWtMO7vZxovxhT81TZrv9Sm3I64
         82oVG3sAdZ4ZslewUyLSFQPnTJJerJg5INEhRUYF5QgBwKXOXlPo8ADqoEGgUCAIIL
         kL1lv+jrfLH+w==
Message-ID: <f81c761a4b43c8343dfb972c8b954cd25cfeeefa.camel@kernel.org>
Subject: Re: [PATCH] nfsd: lock_rename() needs both directories to live on
 the same fs
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-nfs@vger.kernel.org
Date:   Sun, 15 Oct 2023 16:44:17 -0400
In-Reply-To: <20231015172927.GE800259@ZenIV>
References: <20231015172927.GE800259@ZenIV>
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

On Sun, 2023-10-15 at 18:29 +0100, Al Viro wrote:
> ... checking that after lock_rename() is too late.  Incidentally,
> NFSv2 had no nfserr_xdev...
>=20
> Fixes: aa387d6ce153 "nfsd: fix EXDEV checking in rename"
> Cc: stable@vger.kernel.org # v3.9+
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>=20
> [in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #nfsd-fix;
> it's an immutable branch, please either pull from it or put that thing
> into an immutable branch in your tree - there's a lock_rename-related
> series in the making and I'd rather avoid mixing unrelated nfsd stuff
> into it ;-/]
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 48260cf68fde..02f5fcaad03f 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1788,6 +1788,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh =
*ffhp, char *fname, int flen,
>  	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
>  		goto out;
> =20
> +	err =3D (rqstp->rq_vers =3D=3D 2) ? nfserr_acces : nfserr_xdev;
> +	if (ffhp->fh_export->ex_path.mnt !=3D tfhp->fh_export->ex_path.mnt)
> +		goto out;
> +	if (ffhp->fh_export->ex_path.dentry !=3D tfhp->fh_export->ex_path.dentr=
y)
> +		goto out;
> +
>  retry:
>  	host_err =3D fh_want_write(ffhp);
>  	if (host_err) {
> @@ -1823,12 +1829,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh =
*ffhp, char *fname, int flen,
>  	if (ndentry =3D=3D trap)
>  		goto out_dput_new;
> =20
> -	host_err =3D -EXDEV;
> -	if (ffhp->fh_export->ex_path.mnt !=3D tfhp->fh_export->ex_path.mnt)
> -		goto out_dput_new;
> -	if (ffhp->fh_export->ex_path.dentry !=3D tfhp->fh_export->ex_path.dentr=
y)
> -		goto out_dput_new;
> -
>  	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK)=
 &&
>  	    nfsd_has_cached_files(ndentry)) {
>  		close_cached =3D true;


I ran this through pynfs and fstests (via kdevops) and it seemed to do
fine. You can also add:

Tested-by: Jeff Layton <jlayton@kernel.org>
