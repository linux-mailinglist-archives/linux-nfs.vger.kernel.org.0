Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE60075B9BB
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 23:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGTVqb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 17:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGTVqa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 17:46:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3C71719;
        Thu, 20 Jul 2023 14:46:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CB85D1F8B2;
        Thu, 20 Jul 2023 21:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689889587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hG4r8cgG3O5UbpyyD+btGzhMwzwAajaXTDnWtwsHJM=;
        b=LRDG8npbqS0CjVuh7bApHglng2PRPlSK6Cgv43obqs4DBCwjFBQu1R3kwbm1exHKV3NZDL
        oKkn++wnom+ven6d8yLDB+taVMycymE5C5I8IZyY1x0luhfeL3cS72KpeffnfGKPCxM/zl
        FA59PVVa56p96RGrGtlQyw5JxCAFUu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689889587;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hG4r8cgG3O5UbpyyD+btGzhMwzwAajaXTDnWtwsHJM=;
        b=Ov+9REl4J6nRYr6uh5qlF0J5v/xI/rKWuEHBQ1yUX/TUd8PbG30qdZLdkM3n160Lz12bpM
        uUqOoKQvo51QPwDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1042C138EC;
        Thu, 20 Jul 2023 21:46:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /k50LTCruWRDQQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 20 Jul 2023 21:46:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
        "Boyang Xue" <bxue@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v2 1/2] nfsd: handle failure to collect pre/post-op attrs
 more sanely
In-reply-to: <20230720-bz2223560-v2-1-070aaf2660b7@kernel.org>
References: <20230720-bz2223560-v2-0-070aaf2660b7@kernel.org>,
 <20230720-bz2223560-v2-1-070aaf2660b7@kernel.org>
Date:   Fri, 21 Jul 2023 07:46:20 +1000
Message-id: <168988958067.11078.10143293324143654882@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 21 Jul 2023, Jeff Layton wrote:
> Collecting pre_op_attrs can fail, in which case it's probably best to
> fail the whole operation.
>=20
> Change fh_fill_{pre,post,both}_attrs to return __be32. For the pre and
> both functions, have the callers check the return code and abort the
> operation if it failed.
>=20
> If fh_fill_post_attrs fails, then it's too late to do anything about it,
> so most of those callers ignore the return value. If this happens, then
> fh_post_saved will be false, which should cue the later stages to deal
> with it.
>=20
> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs3proc.c |  4 +++-
>  fs/nfsd/nfs4proc.c | 14 ++++++------
>  fs/nfsd/nfsfh.c    | 26 ++++++++++++++---------
>  fs/nfsd/nfsfh.h    |  6 +++---
>  fs/nfsd/vfs.c      | 62 ++++++++++++++++++++++++++++++++++----------------=
----
>  5 files changed, 69 insertions(+), 43 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index fc8d5b7db9f8..268ef57751c4 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -307,7 +307,9 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>  	if (!IS_POSIXACL(inode))
>  		iap->ia_mode &=3D ~current_umask();
> =20
> -	fh_fill_pre_attrs(fhp);
> +	status =3D fh_fill_pre_attrs(fhp);
> +	if (status !=3D nfs_ok)
> +		goto out;
>  	host_err =3D vfs_create(&nop_mnt_idmap, inode, child, iap->ia_mode, true);
>  	if (host_err < 0) {
>  		status =3D nfserrno(host_err);
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index d8e7a533f9d2..9285e1eab4d5 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -297,12 +297,12 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
>  	}
> =20
>  	if (d_really_is_positive(child)) {
> -		status =3D nfs_ok;
> -
>  		/* NFSv4 protocol requires change attributes even though
>  		 * no change happened.
>  		 */
> -		fh_fill_both_attrs(fhp);
> +		status =3D fh_fill_both_attrs(fhp);
> +		if (status !=3D nfs_ok)
> +			goto out;
> =20
>  		switch (open->op_createmode) {
>  		case NFS4_CREATE_UNCHECKED:
> @@ -345,7 +345,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>  	if (!IS_POSIXACL(inode))
>  		iap->ia_mode &=3D ~current_umask();
> =20
> -	fh_fill_pre_attrs(fhp);
> +	status =3D fh_fill_pre_attrs(fhp);
> +	if (status !=3D nfs_ok)
> +		goto out;
>  	status =3D nfsd4_vfs_create(fhp, child, open);
>  	if (status !=3D nfs_ok)
>  		goto out;
> @@ -424,11 +426,11 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate, stru
>  	} else {
>  		status =3D nfsd_lookup(rqstp, current_fh,
>  				     open->op_fname, open->op_fnamelen, *resfh);
> -		if (!status)
> +		if (status =3D=3D nfs_ok)
>  			/* NFSv4 protocol requires change attributes even though
>  			 * no change happened.
>  			 */
> -			fh_fill_both_attrs(current_fh);
> +			status =3D fh_fill_both_attrs(current_fh);
>  	}
>  	if (status)
>  		goto out;
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index c291389a1d71..f7e68a91e826 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -614,7 +614,7 @@ fh_update(struct svc_fh *fhp)
>   * @fhp: file handle to be updated
>   *
>   */
> -void fh_fill_pre_attrs(struct svc_fh *fhp)
> +__be32 fh_fill_pre_attrs(struct svc_fh *fhp)
>  {
>  	bool v4 =3D (fhp->fh_maxsize =3D=3D NFS4_FHSIZE);
>  	struct inode *inode;
> @@ -622,12 +622,12 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
>  	__be32 err;
> =20
>  	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
> -		return;
> +		return nfs_ok;
> =20
>  	inode =3D d_inode(fhp->fh_dentry);
>  	err =3D fh_getattr(fhp, &stat);
>  	if (err)
> -		return;
> +		return err;
> =20
>  	if (v4)
>  		fhp->fh_pre_change =3D nfsd4_change_attribute(&stat, inode);
> @@ -636,6 +636,7 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
>  	fhp->fh_pre_ctime =3D stat.ctime;
>  	fhp->fh_pre_size  =3D stat.size;
>  	fhp->fh_pre_saved =3D true;
> +	return nfs_ok;
>  }
> =20
>  /**
> @@ -643,26 +644,27 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
>   * @fhp: file handle to be updated
>   *
>   */
> -void fh_fill_post_attrs(struct svc_fh *fhp)
> +__be32 fh_fill_post_attrs(struct svc_fh *fhp)
>  {
>  	bool v4 =3D (fhp->fh_maxsize =3D=3D NFS4_FHSIZE);
>  	struct inode *inode =3D d_inode(fhp->fh_dentry);
>  	__be32 err;
> =20
>  	if (fhp->fh_no_wcc)
> -		return;
> +		return nfs_ok;
> =20
>  	if (fhp->fh_post_saved)
>  		printk("nfsd: inode locked twice during operation.\n");
> =20
>  	err =3D fh_getattr(fhp, &fhp->fh_post_attr);
>  	if (err)
> -		return;
> +		return err;
> =20
>  	fhp->fh_post_saved =3D true;
>  	if (v4)
>  		fhp->fh_post_change =3D
>  			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
> +	return nfs_ok;
>  }
> =20
>  /**
> @@ -672,16 +674,20 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
>   * This is used when the directory wasn't changed, but wcc attributes
>   * are needed anyway.
>   */
> -void fh_fill_both_attrs(struct svc_fh *fhp)
> +__be32 fh_fill_both_attrs(struct svc_fh *fhp)
>  {
> -	fh_fill_post_attrs(fhp);
> -	if (!fhp->fh_post_saved)
> -		return;
> +	__be32 err;
> +
> +	err =3D fh_fill_post_attrs(fhp);
> +	if (err)
> +		return err;
> +
>  	fhp->fh_pre_change =3D fhp->fh_post_change;
>  	fhp->fh_pre_mtime =3D fhp->fh_post_attr.mtime;
>  	fhp->fh_pre_ctime =3D fhp->fh_post_attr.ctime;
>  	fhp->fh_pre_size =3D fhp->fh_post_attr.size;
>  	fhp->fh_pre_saved =3D true;
> +	return nfs_ok;
>  }
> =20
>  /*
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 4e0ecf0ae2cf..486803694acc 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -294,7 +294,7 @@ static inline void fh_clear_pre_post_attrs(struct svc_f=
h *fhp)
>  }
> =20
>  u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode);
> -extern void fh_fill_pre_attrs(struct svc_fh *fhp);
> -extern void fh_fill_post_attrs(struct svc_fh *fhp);
> -extern void fh_fill_both_attrs(struct svc_fh *fhp);
> +__be32 fh_fill_pre_attrs(struct svc_fh *fhp);
> +__be32 fh_fill_post_attrs(struct svc_fh *fhp);
> +__be32 fh_fill_both_attrs(struct svc_fh *fhp);
>  #endif /* _LINUX_NFSD_NFSFH_H */
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 8a2321d19194..f200afd33630 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1537,9 +1537,11 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
>  	dput(dchild);
>  	if (err)
>  		goto out_unlock;
> -	fh_fill_pre_attrs(fhp);
> -	err =3D nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
> -	fh_fill_post_attrs(fhp);
> +	err =3D fh_fill_pre_attrs(fhp);
> +	if (err =3D=3D nfs_ok) {
> +		err =3D nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
> +		fh_fill_post_attrs(fhp);

Most error handling in nfsd is
=20
   if (err)
       goto ....

Here (and one other place I think) you have
   if (not err)
       do stuff;

Do we want to be more consistent?  I'm in two minds about this and I
don't dislike your patch.  But I noticed the inconsistency and thought I
should mention it.

Also, should we put a __must_check annotation on fh_fill_pre_attrs() and
..post..?  Then I wouldn't have to manually check that you found and
fixed all callers (which I haven't).

Thanks,
NeilBrown
