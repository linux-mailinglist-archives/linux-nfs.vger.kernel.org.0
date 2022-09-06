Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7545AE559
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 12:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbiIFK2O (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Sep 2022 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239440AbiIFK12 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Sep 2022 06:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468F413E39
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 03:27:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D48F761362
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 10:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE662C433C1;
        Tue,  6 Sep 2022 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662460045;
        bh=5JMjGPfTZqr1dG3VQOyjfiKc3Jxqa/X3SQvg1dnJUqU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=njPl1bqQ56sNjGMOBm7StjIkcHDNNqKk69VwKgBux2zjwpnqqNNmEFxihOtTIMJOa
         tGkZwHqKdMAdLDFkQnEGdeFBB9mEqadtiSpiNTETXuDHHtaHuzcgWNbmlVd223ui/d
         LDlbeLz+OVg9GgfHQv8FPi6pUBDTDEZbNsLuDrrsCmeMrqSeO6EX7RcXT13AaJAxCI
         MayGWn1gf+Ltwal+BWsgflHNtADEMrdIy1mXetyy0xagmGZxsHZYJd54xZWWdNIdrD
         zMRLD5B9eMo2+VtLG1+LgxJN2y8xzS7d4q/NfWIdOu7sIMqWCMqrfc9/Kp2oJRcoQQ
         pzOzpvKBq2YeA==
Message-ID: <b6cd9aeb346e68348aad68befcae236898afde31.camel@kernel.org>
Subject: Re: [PATCH] NFSD: drop fname and flen args from nfsd_create_locked()
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 06 Sep 2022 06:27:23 -0400
In-Reply-To: <166242493965.1168.6227147868888984691@noble.neil.brown.name>
References: <166242493965.1168.6227147868888984691@noble.neil.brown.name>
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

On Tue, 2022-09-06 at 10:42 +1000, NeilBrown wrote:
> nfsd_create_locked() does not use the "fname" and "flen" arguments, so
> drop them from declaration and all callers.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfsproc.c | 4 ++--
>  fs/nfsd/vfs.c     | 4 ++--
>  fs/nfsd/vfs.h     | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 7381972f1677..9c766ac2cc68 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -390,8 +390,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  	resp->status =3D nfs_ok;
>  	if (!inode) {
>  		/* File doesn't exist. Create it and set attrs */
> -		resp->status =3D nfsd_create_locked(rqstp, dirfhp, argp->name,
> -						  argp->len, &attrs, type, rdev,
> +		resp->status =3D nfsd_create_locked(rqstp, dirfhp,
> +						  &attrs, type, rdev,
>  						  newfhp);
>  	} else if (type =3D=3D S_IFREG) {
>  		dprintk("nfsd:   existing %s, valid=3D%x, size=3D%ld\n",
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 9f486b788ed0..528afc3be7af 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1252,7 +1252,7 @@ nfsd_check_ignore_resizing(struct iattr *iap)
>  /* The parent directory should already be locked: */
>  __be32
>  nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		   char *fname, int flen, struct nfsd_attrs *attrs,
> +		   struct nfsd_attrs *attrs,
>  		   int type, dev_t rdev, struct svc_fh *resfhp)
>  {
>  	struct dentry	*dentry, *dchild;
> @@ -1379,7 +1379,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
>  	if (err)
>  		goto out_unlock;
>  	fh_fill_pre_attrs(fhp);
> -	err =3D nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
> +	err =3D nfsd_create_locked(rqstp, fhp, attrs, type,
>  				 rdev, resfhp);
>  	fh_fill_post_attrs(fhp);
>  out_unlock:
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index c95cd414b4bb..0bf5c7e79abe 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -79,7 +79,7 @@ __be32		nfsd4_clone_file_range(struct svc_rqst *rqstp,
>  				       u64 count, bool sync);
>  #endif /* CONFIG_NFSD_V4 */
>  __be32		nfsd_create_locked(struct svc_rqst *, struct svc_fh *,
> -				char *name, int len, struct nfsd_attrs *attrs,
> +				struct nfsd_attrs *attrs,
>  				int type, dev_t rdev, struct svc_fh *res);
>  __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
>  				char *name, int len, struct nfsd_attrs *attrs,


Reviewed-by: Jeff Layton <jlayton@kernel.org>
