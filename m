Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3CC649E97
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 13:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiLLMWU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 07:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiLLMWQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 07:22:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9A2AE5E
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 04:22:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73A0CB80D1C
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 12:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E5FC433F2;
        Mon, 12 Dec 2022 12:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670847730;
        bh=2VvoCvpW8t3MbIKDQk4dMyCN2CBcRQNWQacyP8HD2o4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WY9/PflX9XXSEMwjzgKMQ06OOf/+vynYLFem6cg+eBCKATqnd21bA1NgtuSQ3kIlm
         835MMsCGIIHPKX7iFBuSrOsEOQIEvPTlffEypjaYRc1QkhfQSV4P50WcNTfaA+sUDl
         juUIQkrGInupSJZGqGxgj2yxhHXbZwbRsKUdlJw6ZfPzU8xOOHLegl41FFGjRH9whI
         un4BJy02DwS/SON85FKwd1s2ffq6o0FZmRufeR5prlbHiiKXrxjkl5N3ecI5KlAq35
         5n8ZD97l4JiCwAekPoM7wBzGLbdr/nA/O1UFEO4BACqO9cJmJZsFD/UDK0uv/k9MMd
         tceR2PbTtrclA==
Message-ID: <7f68cb23445820b4a1c12b74dce0954f537ae5e2.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     kolga@netapp.com, hdthky0@gmail.com, linux-nfs@vger.kernel.org,
        security@kernel.org
Date:   Mon, 12 Dec 2022 07:22:08 -0500
In-Reply-To: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
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

On Sun, 2022-12-11 at 11:22 -0800, Dai Ngo wrote:
> Problem caused by source's vfsmount being unmounted but remains
> on the delayed unmount list. This happens when nfs42_ssc_open()
> return errors.
> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
> for the laundromat to unmount when idle time expires.
>=20
> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 8beb2bc4c328..756e42cf0d01 100644
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
> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, s=
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
> @@ -1762,7 +1750,8 @@ static int nfsd4_do_async_copy(void *data)
>  		struct file *filp;
> =20
>  		filp =3D nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
> -				      &copy->stateid);
> +					&copy->stateid);
> +
>  		if (IS_ERR(filp)) {
>  			switch (PTR_ERR(filp)) {
>  			case -EBADF:
> @@ -1771,7 +1760,7 @@ static int nfsd4_do_async_copy(void *data)
>  			default:
>  				nfserr =3D nfserr_offload_denied;
>  			}
> -			nfsd4_interssc_disconnect(copy->ss_mnt);
> +			/* ss_mnt will be unmounted by the laundromat */
>  			goto do_callback;
>  		}
>  		nfserr =3D nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
> @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_co=
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

This looks reasonable at first glance, but I have some concerns with the
refcounting around ss_mnt elsewhere in this code.=A0nfsd4_ssc_setup_dul
looks for an existing connection and bumps the ni->nsui_refcnt if it
finds one.

But then later, nfsd4_cleanup_inter_ssc has a couple of cases where it
just does a bare mntput:

        if (!nn) {
                mntput(ss_mnt);
                return;
        }
...
        if (!found) {
                mntput(ss_mnt);
                return;
        }

The first one looks bogus. Can net_generic return NULL? If so how, and
why is it not a problem elsewhere in the kernel?

For the second case, if the ni is no longer on the list, where did the
extra ss_mnt reference come from? Maybe that should be a WARN_ON or
BUG_ON?
--=20
Jeff Layton <jlayton@kernel.org>
