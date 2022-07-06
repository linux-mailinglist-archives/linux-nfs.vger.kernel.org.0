Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A446568978
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 15:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiGFNaW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 09:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiGFNaW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 09:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15DC220F3
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 06:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5860161D89
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 13:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F053AC3411C;
        Wed,  6 Jul 2022 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657114220;
        bh=ZYjQjH83pzdIV9MOB3BjShKDRHVXzd2nsGwTKCUyX4M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dcdNlsvPkUgG6GmWg14yGdqFUXWqpfugeROpBAadKxr5Zb9U3qX2d/+Z2QUZ305Da
         /ZSD1e2sKMXDW3bkD1f8Oly7M+26qjJjsIgepuNX5IuJynoCG9JwP2mqEDQSgIoV1a
         xJnULdpC4p3ilmtQ8euta/6IZyL/RFe/UCNLy+9cgUlrfw8VFSn1nut77qGc9D1FEd
         xXorRGg7xxdLbk/RFThKxXkcQJnF6OFCnGg+hxTuedOdhEuDM7SoDP2egSUPFK+FaN
         CgfcEoEDWo5JqqdO9Z0shqICTikuoMPy0Eo5SbWh7WmJ//wej777+ob62Hwn2BZvmW
         3yuYlbzvOLGCg==
Message-ID: <105f33d12c2f2d74f4102721a596bc321baf777f.camel@kernel.org>
Subject: Re: [PATCH 3/8] NFSD: always drop directory lock in nfsd_unlink()
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 06 Jul 2022 09:30:17 -0400
In-Reply-To: <165708109257.1940.5635801592688577227.stgit@noble.brown>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
         <165708109257.1940.5635801592688577227.stgit@noble.brown>
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
> Some error paths in nfsd_unlink() allow it to exit without unlocking the
> directory.  This is not a problem in practice as the directory will be
> locked with an fh_put(), but it is untidy and potentially confusing.
>=20
> This allows us to remove all the fh_unlock() calls that are immediately
> after nfsd_unlink() calls.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs3proc.c |    2 --
>  fs/nfsd/nfs4proc.c |    4 +---
>  fs/nfsd/vfs.c      |    7 +++++--
>  3 files changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 38255365ef71..ad7941001106 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -478,7 +478,6 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->status =3D nfsd_unlink(rqstp, &resp->fh, -S_IFDIR,
>  				   argp->name, argp->len);
> -	fh_unlock(&resp->fh);
>  	return rpc_success;
>  }
> =20
> @@ -499,7 +498,6 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
>  	fh_copy(&resp->fh, &argp->fh);
>  	resp->status =3D nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
>  				   argp->name, argp->len);
> -	fh_unlock(&resp->fh);
>  	return rpc_success;
>  }
> =20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 3279daab909d..4737019738ab 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1052,10 +1052,8 @@ nfsd4_remove(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
>  		return nfserr_grace;
>  	status =3D nfsd_unlink(rqstp, &cstate->current_fh, 0,
>  			     remove->rm_name, remove->rm_namelen);
> -	if (!status) {
> -		fh_unlock(&cstate->current_fh);
> +	if (!status)
>  		set_change_info(&remove->rm_cinfo, &cstate->current_fh);
> -	}
>  	return status;
>  }
> =20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 1e7ca39e8a49..3f4579f5775c 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1762,12 +1762,12 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, int type,
>  	rdentry =3D lookup_one_len(fname, dentry, flen);
>  	host_err =3D PTR_ERR(rdentry);
>  	if (IS_ERR(rdentry))
> -		goto out_drop_write;
> +		goto out_unlock;
> =20
>  	if (d_really_is_negative(rdentry)) {
>  		dput(rdentry);
>  		host_err =3D -ENOENT;
> -		goto out_drop_write;
> +		goto out_unlock;
>  	}
>  	rinode =3D d_inode(rdentry);
>  	ihold(rinode);
> @@ -1805,6 +1805,9 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *=
fhp, int type,
>  	}
>  out:
>  	return err;
> +out_unlock:
> +	fh_unlock(fhp);
> +	goto out_drop_write;
>  }
> =20
>  /*
>=20
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
