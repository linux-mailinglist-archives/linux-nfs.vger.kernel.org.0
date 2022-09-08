Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A3C5B241E
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 19:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiIHRAx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 13:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIHRAu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 13:00:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407B3C4831
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 10:00:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E011DB818B5
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 17:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A01DC433D6;
        Thu,  8 Sep 2022 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662656446;
        bh=1eY/HOWwy2efhbRjsiAhA60K8ylM9PwTnRJ2H6lYYmI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L+mOrxiGJhskJoLaWQPv8f4jkiaBtA/CU1sBHKY8G1yV0PpRqebKP2UiVDn0OBgpZ
         BNwDromGXYs0TCgNfkG5p671vTGySVwq+VFwnrk3LlqU25iS8JAKx2KX90Dhlssnvp
         kb3Qz+vV/a+jIr9kzb/aujemUtVZ+svsFNzIyGHbcFsojb/JsZBuSWk0mSfpI9gZiW
         c2iEkLbHmE8YaruIL4ELa0Q/XNH9B3E0Y4jbcz416RUKbnRBOX3TVFV98KZqFzonDs
         FbiTuw75uOI85q8iqlZq3edZABTB5FZvcFWrzEhM1Sp2+qfapsNea8dfXc5KL0D9ST
         ejZLw0pjNWdgA==
Message-ID: <3ecdb5e4baff87b3dcfb77ce3dc7b6336b9832ce.camel@kernel.org>
Subject: Re: [PATCH] nfsd: clean up mounted_on_fileid handling
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 08 Sep 2022 13:00:44 -0400
In-Reply-To: <20220908163107.202597-1-jlayton@kernel.org>
References: <20220908163107.202597-1-jlayton@kernel.org>
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

On Thu, 2022-09-08 at 12:31 -0400, Jeff Layton wrote:
> We only need the inode number for this, not a full rack of attributes.
> Rename this function make it take a pointer to a u64 instead of
> struct kstat, and change it to just request STATX_INO.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4xdr.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 1e9690a061ec..5980df859c3a 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2774,9 +2774,10 @@ static __be32 fattr_handle_absent_fs(u32 *bmval0, =
u32 *bmval1, u32 *bmval2, u32
>  }
> =20
> =20
> -static int get_parent_attributes(struct svc_export *exp, struct kstat *s=
tat)
> +static int get_mounted_on_ino(struct svc_export *exp, u64 *pino)
>  {
>  	struct path path =3D exp->ex_path;
> +	struct kstat stat;
>  	int err;
> =20
>  	path_get(&path);
> @@ -2784,8 +2785,10 @@ static int get_parent_attributes(struct svc_export=
 *exp, struct kstat *stat)
>  		if (path.dentry !=3D path.mnt->mnt_root)
>  			break;
>  	}
> -	err =3D vfs_getattr(&path, stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS_ST=
AT);
> +	err =3D vfs_getattr(&path, &stat, STATX_INO, AT_STATX_SYNC_AS_STAT);

We could also consider using AT_STATX_DONT_SYNC here as well, but it's
probably not worthwhile. Just asking for the inode number shouldn't
result in any I/O in a sanely-written getattr.

>  	path_put(&path);
> +	if (!err)
> +		*pino =3D stat.ino;
>  	return err;
>  }
> =20
> @@ -3282,22 +3285,21 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct=
 svc_fh *fhp,
>  		*p++ =3D cpu_to_be32(stat.btime.tv_nsec);
>  	}
>  	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
> -		struct kstat parent_stat;
>  		u64 ino =3D stat.ino;
> =20
>  		p =3D xdr_reserve_space(xdr, 8);
>  		if (!p)
>                  	goto out_resource;
>  		/*
> -		 * Get parent's attributes if not ignoring crossmount
> -		 * and this is the root of a cross-mounted filesystem.
> +		 * Get ino of mountpoint in parent filesystem, if not ignoring
> +		 * crossmount and this is the root of a cross-mounted
> +		 * filesystem.
>  		 */
>  		if (ignore_crossmnt =3D=3D 0 &&
>  		    dentry =3D=3D exp->ex_path.mnt->mnt_root) {
> -			err =3D get_parent_attributes(exp, &parent_stat);
> +			err =3D get_mounted_on_ino(exp, &ino);
>  			if (err)
>  				goto out_nfserr;
> -			ino =3D parent_stat.ino;
>  		}
>  		p =3D xdr_encode_hyper(p, ino);
>  	}

--=20
Jeff Layton <jlayton@kernel.org>
