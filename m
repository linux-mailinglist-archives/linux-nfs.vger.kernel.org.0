Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F1C5778F2
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Jul 2022 02:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiGRAAH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Jul 2022 20:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiGRAAG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Jul 2022 20:00:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2774F12A81
        for <linux-nfs@vger.kernel.org>; Sun, 17 Jul 2022 17:00:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A656C20544;
        Mon, 18 Jul 2022 00:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658102403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxGy6Iff4591Td1q7RnPeMDGgLsq3pC/nzhRniB6ogw=;
        b=wWycUr/6YfcqroHnFYJdF6m7V8yGGDVpyAeYFyNJ2rV6DSe6Kjp1msUSNbkvaT0iQ0XTHg
        fMOPfsew+wDopGkXovkGB9wPazdJpg4EUw19Wk3o/nKVnxMwrUGrteo3eJkH85+C88l8or
        XD51zUw4XhDYklVFe76n5KrpzAt83Gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658102403;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxGy6Iff4591Td1q7RnPeMDGgLsq3pC/nzhRniB6ogw=;
        b=wMIDYJUsjItSunSQ7x6XuA/qNTvW5f2H+l72z79hKEutEzYIf+lnyGMyU/ibwvr4vFtL1V
        gShyXhHe3zma/1DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84FF313A89;
        Mon, 18 Jul 2022 00:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CKAzD4Ki1GJebwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 18 Jul 2022 00:00:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/8] NFSD: use explicit lock/unlock for directory ops
In-reply-to: <b7cff63a128cf1d45296d38f569c4dd375184d41.camel@kernel.org>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>,
 <165708109259.1940.685583862810495747.stgit@noble.brown>,
 <ccc3c78c5a6b4b72f6160aeb38ffa36cec94595f.camel@kernel.org>,
 <b7cff63a128cf1d45296d38f569c4dd375184d41.camel@kernel.org>
Date:   Mon, 18 Jul 2022 09:59:59 +1000
Message-id: <165810239926.25184.11331523885793016989@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 16 Jul 2022, Jeff Layton wrote:
> On Fri, 2022-07-15 at 12:11 -0400, Jeff Layton wrote:
>=20
>=20
> [PATCH] SQUASH: nfsd: ensure we fill in pre-op-attrs in
>  nfsd4_create_file
>=20
> In some cases, they're left uninitialized. This also ensures that the
> post_op attrs are properly filled in all cases too.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks Jeff, but I think this is more noisy than necessary.
The problem is that the d_really_is_positive() doesn't actually change
the directory (obviously) but can succeed - so pre/post attributes are
needed by NFSv4 even though they aren't really relevant.

I would rather use the same approach as in the !open->op_create branch
in d_open_lookup() :
			fh_fill_pre_attrs(current_fh);
			fh_fill_post_attrs(current_fh);
with a comment explaining that as the directory is locked, and as it
isn't being changed, this makes sense.

I'll fold that in.

Thanks,
NeilBrown


> ---
>  fs/nfsd/nfs4proc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 242f059e6788..05652a7dabe8 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -346,6 +346,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
> =20
>  		switch (open->op_createmode) {
>  		case NFS4_CREATE_UNCHECKED:
> +			fh_fill_pre_attrs(fhp);
>  			if (!d_is_reg(child))
>  				break;
> =20
> @@ -365,6 +366,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>  			if (d_inode(child)->i_mtime.tv_sec =3D=3D v_mtime &&
>  			    d_inode(child)->i_atime.tv_sec =3D=3D v_atime &&
>  			    d_inode(child)->i_size =3D=3D 0) {
> +				fh_fill_pre_attrs(fhp);
>  				open->op_created =3D true;
>  				break;		/* subtle */
>  			}
> @@ -374,6 +376,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>  			if (d_inode(child)->i_mtime.tv_sec =3D=3D v_mtime &&
>  			    d_inode(child)->i_atime.tv_sec =3D=3D v_atime &&
>  			    d_inode(child)->i_size =3D=3D 0) {
> +				fh_fill_pre_attrs(fhp);
>  				open->op_created =3D true;
>  				goto set_attr;	/* subtle */
>  			}
> @@ -385,12 +388,10 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>  	if (!IS_POSIXACL(inode))
>  		iap->ia_mode &=3D ~current_umask();
> =20
> -	fh_fill_pre_attrs(fhp);
>  	status =3D nfsd4_vfs_create(fhp, child, open);
>  	if (status !=3D nfs_ok)
>  		goto out;
>  	open->op_created =3D true;
> -	fh_fill_post_attrs(fhp);
> =20
>  	/* A newly created file already has a file size of zero. */
>  	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size =3D=3D 0))
> @@ -408,6 +409,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>  	status =3D nfsd_create_setattr(rqstp, fhp, resfhp, iap);
> =20
>  out:
> +	if (status =3D=3D nfs_ok)
> +		fh_fill_post_attrs(fhp);
>  	inode_unlock(inode);
>  	if (child && !IS_ERR(child))
>  		dput(child);
> --=20
> 2.36.1
>=20
>=20
>=20
