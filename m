Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8D664A402
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 16:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiLLPTd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 10:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiLLPTc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 10:19:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2EDF024
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 07:19:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB66D61122
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 15:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8774FC433EF;
        Mon, 12 Dec 2022 15:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670858370;
        bh=8yX4KFu5pxQ1x3qxpRtT8Cq/GultLKCEJcjFwnpSq/8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lZtEvtZuRkMHa34eT2Z6BUEEPYWYYdMC6Q5x+JYaBNwLzGs75YpIqQ9RTLyARVQaP
         jhaoLbFgJ1tuf3wWHu6IcykUVYM50CYJZi/vKfCHQlTp6tQnlyrJSGOUGayNsx4fdO
         YHM0N5HuEAJWbyMC1tnHS6kwoa2ctRNwN2aTno8BMlCRxK/GzOoBBvFMAl++cPQ1hJ
         20TwfecMAaUkrMNDjeYQlWiphReosVR9AczBDH/pEUAKiwoobfN5IhxAEVY8DWA6OW
         /xh/V+JLdH2cmPUTEA8UzeVQt+WQiWOx+YVF94ms3Ahm2hegsR7nf6tVik03oxkEB2
         SMaLjHj4MaEpw==
Message-ID: <bfd07fb72616b5c634ec52c46e33cc562cb92dfa.camel@kernel.org>
Subject: Re: [PATCH v2 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     kolga@netapp.com, hdthky0@gmail.com, linux-nfs@vger.kernel.org,
        security@kernel.org
Date:   Mon, 12 Dec 2022 10:19:28 -0500
In-Reply-To: <1670857869-14618-1-git-send-email-dai.ngo@oracle.com>
References: <1670857869-14618-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-12-12 at 07:11 -0800, Dai Ngo wrote:
> Problem caused by source's vfsmount being unmounted but remains
> on the delayed unmount list. This happens when nfs42_ssc_open()
> return errors.
>=20
> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
> for the laundromat to unmount when idle time expires.
>=20
> Removed unneeded check for NULL nfsd_net and added pr_warn
> if vfsmount not found on delayed unmount list.
>=20
> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 32 ++++++++------------------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 8beb2bc4c328..84646df60212 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, str=
uct svc_rqst *rqstp,
>  	return status;
>  }
> =20
> -static void
> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> -{
> -	nfs_do_sb_deactive(ss_mnt->mnt_sb);
> -	mntput(ss_mnt);
> -}
> -
>  /*
>   * Verify COPY destination stateid.
>   *
> @@ -1526,10 +1519,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, s=
truct file *filp,
>  	nfsd_file_put(dst);
>  	fput(filp);
> =20
> -	if (!nn) {
> -		mntput(ss_mnt);
> -		return;
> -	}
>  	spin_lock(&nn->nfsd_ssc_lock);
>  	timeout =3D msecs_to_jiffies(nfsd4_ssc_umount_timeout);
>  	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) =
{
> @@ -1548,10 +1537,8 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, s=
truct file *filp,
>  		}
>  	}
>  	spin_unlock(&nn->nfsd_ssc_lock);
> -	if (!found) {
> -		mntput(ss_mnt);
> -		return;
> -	}
> +	if (!found)
> +		pr_warn("vfsmount not found on delayed unmount list\n");
>  }
> =20
>  #else /* CONFIG_NFSD_V4_2_INTER_SSC */
> @@ -1572,11 +1559,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, s=
truct file *filp,
>  {
>  }
> =20
> -static void
> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> -{
> -}
> -
>  static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>  				   struct nfs_fh *src_fh,
>  				   nfs4_stateid *stateid)
> @@ -1762,7 +1744,7 @@ static int nfsd4_do_async_copy(void *data)
>  		struct file *filp;
> =20
>  		filp =3D nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
> -				      &copy->stateid);
> +					&copy->stateid);
>  		if (IS_ERR(filp)) {
>  			switch (PTR_ERR(filp)) {
>  			case -EBADF:
> @@ -1771,7 +1753,7 @@ static int nfsd4_do_async_copy(void *data)
>  			default:
>  				nfserr =3D nfserr_offload_denied;
>  			}
> -			nfsd4_interssc_disconnect(copy->ss_mnt);
> +			/* ss_mnt will be unmounted by the laundromat */
>  			goto do_callback;
>  		}
>  		nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
> @@ -1852,8 +1834,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  	if (async_copy)
>  		cleanup_async_copy(async_copy);
>  	status =3D nfserrno(-ENOMEM);
> -	if (nfsd4_ssc_is_inter(copy))
> -		nfsd4_interssc_disconnect(copy->ss_mnt);
> +	/*
> +	 * source's vfsmount of inter-copy will be unmounted
> +	 * by the laundromat
> +	 */
>  	goto out;
>  }
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
