Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81559568983
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 15:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiGFNbz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 09:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiGFNbz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 09:31:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4F523BFC
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 06:31:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 080B0B81CE0
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 13:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12D8C341CA;
        Wed,  6 Jul 2022 13:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657114311;
        bh=8Cva7wTmnx8X4CQoAE3OrhNMfUklnDZ4/egJWdmQxsY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HvYoHSQqwQaxPC9FZ3+uWHMznbjR868TwTbCEL/frvy7pQFvZTsznz1jiJd04jYhV
         fUT/tpHz8NLeAYYPbeOl8oaxx9IbYyVmdEaEpgw7sCjzTtfZuZBHpb+SDsfDLdhYxs
         VXzXoOrd5Tl+rsTQOTzXjnx0ZA8GAvZMX1jQFX175DGLUb2MYfCevLzLZMfxEHX4M3
         HkYvzg78paAyVCkeBt01wKp3DX5CWH8L2dYdlmWf0Yxmc4E/snFAERGEVxKyss4D1G
         QbBSt9okF5Sgh0gse9FINXdeitlZyfxl0e142XFjORZ5piT8gUXV4XNelYQz72BQdv
         27BMHaWWNVqZA==
Message-ID: <aef89de72767d582ad1726becfd8c7169769b8b2.camel@kernel.org>
Subject: Re: [PATCH 4/8] NFSD: only call fh_unlock() once in nfsd_link()
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 09:31:48 -0400
In-Reply-To: <165708109258.1940.6581517569232462503.stgit@noble.brown>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
         <165708109258.1940.6581517569232462503.stgit@noble.brown>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2022-07-06 at 14:18 +1000, NeilBrown wrote:
> On non-error paths, nfsd_link() calls fh_unlock() twice.  This is safe
> because fh_unlock() records that the unlock has been done and doesn't
> repeat it.
> However it makes the code a little confusing and interferes with changes
> that are planned for directory locking.
>=20
> So rearrange the code to ensure fh_unlock() is called exactly once if
> fh_lock() was called.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/vfs.c |   18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 3f4579f5775c..4916c29af0fa 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1551,8 +1551,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *f=
fhp,
> =20
>  	dnew =3D lookup_one_len(name, ddir, len);
>  	host_err =3D PTR_ERR(dnew);
> -	if (IS_ERR(dnew))
> -		goto out_nfserr;
> +	if (IS_ERR(dnew)) {
> +		err =3D nfserrno(host_err);
> +		goto out_unlock;
> +	}
> =20
>  	dold =3D tfhp->fh_dentry;
> =20
> @@ -1571,17 +1573,17 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *=
ffhp,
>  		else
>  			err =3D nfserrno(host_err);
>  	}
> -out_dput:
>  	dput(dnew);
> -out_unlock:
> -	fh_unlock(ffhp);
> +out_drop_write:
>  	fh_drop_write(tfhp);
>  out:
>  	return err;
> =20
> -out_nfserr:
> -	err =3D nfserrno(host_err);
> -	goto out_unlock;
> +out_dput:
> +	dput(dnew);
> +out_unlock:
> +	fh_unlock(ffhp);
> +	goto out_drop_write;
>  }
> =20
>  static void
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
