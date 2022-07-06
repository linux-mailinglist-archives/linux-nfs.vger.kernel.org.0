Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE2C568936
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiGFNRU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 09:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiGFNRS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 09:17:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742C321E36
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 06:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D74E3B81CE4
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 13:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8577C341CA;
        Wed,  6 Jul 2022 13:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657113431;
        bh=IZCcMizxCdVQzIHzeLzRBw7VJN0pA37ET0z8yGhPGxU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qwuC/FrIjUB8O5gChYO3OPDqOYy43aZeBta/e/pXajOTeJex2c0hjwWisBuO63YJ/
         k7eIvaxq+7tV4JMWp9jwxkUZY6rls8qlOM+aVT7CIs50izxbTRSPhrwfAfcAcnEuaQ
         k8cHKSAc/6L4BOY5tKs26/ZFTFRmdCfreyTAsrGBTo0KsdNDrcIJUuyKPBregiBeZR
         oY5B+hNTvLPYPGSHYE2NiZZTpYmg0sMP54b0nEsfYAZbuH0u1h1m3nhQTrcqbzLOuX
         irogj12/q+9BumS7szw5Yc+uxUDVN0NiRnKRTgA9Y5ir1rwcu3/ytKVTUd8jZEJI13
         vYSrrxEHT2qBA==
Message-ID: <d4ffc3c6e513cb3b1a500b5c2c23700cbf3f4de4.camel@kernel.org>
Subject: Re: [PATCH 1/8] NFSD: drop rqstp arg to do_set_nfs4_acl()
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 09:17:08 -0400
In-Reply-To: <165708109255.1940.15894552631928142042.stgit@noble.brown>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
         <165708109255.1940.15894552631928142042.stgit@noble.brown>
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
> do_set_nfs4_acl() only needs rqstp to pass to nfsd4_set_nfs4_acl()
>=20
> The latter only needs the rqstp to pass to fh_verify().
>=20
> In every case that do_set_nfs4_acl() is called, fh_verify() is not
> needed.  It is only needed for filehandles received from the client, the
> filehandles passed to do_set_nfs4_acl() have just been constructed by
> the server, and so must be valid.
>=20
> So we can change nfsd4_set_nfs4_acl() to only call fh_verify() is rqstp
> is not NULL, and always pass NULL from do_set_nfs4_acl().
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4acl.c  |   12 +++++++-----
>  fs/nfsd/nfs4proc.c |    9 ++++-----
>  2 files changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> index eaa3a0cf38f1..5c9b7e01e8ca 100644
> --- a/fs/nfsd/nfs4acl.c
> +++ b/fs/nfsd/nfs4acl.c
> @@ -753,7 +753,7 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *a=
cl,
> =20
>  __be32
>  nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		struct nfs4_acl *acl)
> +		   struct nfs4_acl *acl)
>  {
>  	__be32 error;
>  	int host_error;
> @@ -762,10 +762,12 @@ nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
>  	struct posix_acl *pacl =3D NULL, *dpacl =3D NULL;
>  	unsigned int flags =3D 0;
> =20
> -	/* Get inode */
> -	error =3D fh_verify(rqstp, fhp, 0, NFSD_MAY_SATTR);
> -	if (error)
> -		return error;
> +	if (rqstp) {
> +		/* Get inode */
> +		error =3D fh_verify(rqstp, fhp, 0, NFSD_MAY_SATTR);
> +		if (error)
> +			return error;
> +	}
> =20
>  	dentry =3D fhp->fh_dentry;
>  	inode =3D d_inode(dentry);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 5af9f8d1feb6..60591ceb4985 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -163,12 +163,11 @@ is_create_with_attrs(struct nfsd4_open *open)
>   * in the returned attr bitmap.
>   */
>  static void
> -do_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		struct nfs4_acl *acl, u32 *bmval)
> +do_set_nfs4_acl(struct svc_fh *fhp, struct nfs4_acl *acl, u32 *bmval)
>  {
>  	__be32 status;
> =20
> -	status =3D nfsd4_set_nfs4_acl(rqstp, fhp, acl);
> +	status =3D nfsd4_set_nfs4_acl(NULL, fhp, acl);
>  	if (status)
>  		/*
>  		 * We should probably fail the whole open at this point,
> @@ -474,7 +473,7 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate, stru
>  		goto out;
> =20
>  	if (is_create_with_attrs(open) && open->op_acl !=3D NULL)
> -		do_set_nfs4_acl(rqstp, *resfh, open->op_acl, open->op_bmval);
> +		do_set_nfs4_acl(*resfh, open->op_acl, open->op_bmval);
> =20
>  	nfsd4_set_open_owner_reply_cache(cstate, open, *resfh);
>  	accmode =3D NFSD_MAY_NOP;
> @@ -861,7 +860,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
>  		nfsd4_security_inode_setsecctx(&resfh, &create->cr_label, create->cr_b=
mval);
> =20
>  	if (create->cr_acl !=3D NULL)
> -		do_set_nfs4_acl(rqstp, &resfh, create->cr_acl,
> +		do_set_nfs4_acl(&resfh, create->cr_acl,
>  				create->cr_bmval);
> =20
>  	fh_unlock(&cstate->current_fh);
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
