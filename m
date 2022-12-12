Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB4649D7E
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 12:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiLLLXt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 06:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiLLLX1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 06:23:27 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D6226C0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 03:22:49 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so13625902pjb.0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 03:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XXB/aQ1KI3TUt8awhqzv0sGPGhdvap9bGuhaC5H6Qrc=;
        b=HU4he0rjFXPYEWZKMENlB1iULduovU2bn3MJwO2HdFN2tGEuradCIB7rjHy91FPgJW
         jdMWDiyyA6jC1xpPcRf9VpqmfD7UG9X716ZCKqlStujzfYLubh+uiw5FxPrF1ianG6tK
         byt2aI3qyHafzPYnr8BPdJmXr7c8rBwfVUmWas8GOHM6AmAMevPeAJvFaarQzTDP1Ns1
         /zaBk9G5YAa3HrqJAgINdyw65VdckJhsMfSdoY0z4jmVu2pLFpiUHAcTsUf7FwCQUcbh
         rFh/zyQyJ402yGn1s0dziOtvU5MgXMwIPaYjcHlJnMx4DAL3s/louuTVjDKAEECsNPi6
         Hl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXB/aQ1KI3TUt8awhqzv0sGPGhdvap9bGuhaC5H6Qrc=;
        b=it+2/6cCrAexf9GC4fgkXDBYdo8UiBNKTmR+PS8Xh1xadp0DJxQ0ZJrBZA2s9y/mA9
         WUIwGet4t1ZFWiBt6tSDTDFphb5OhNIbSILJN2ebToW3y0vFQDrZCj2sOJsqqecA7KO2
         n0eD8Dfr5nPYJ9+lq+tmfz9qYRPFaJ5kgy04z4tmxbbFYlrrxvbWARMdyXjjQF+5hoM+
         raLtLUupaU3bsmOQoQgyKvB9B6yKgrJRcnsv88g9Q80VZt/iBojgAMgZZaJmT7wqarga
         Qpj/k1NjtT7+xjksaK/YcVLgmbd/PoB/1i8Tnmf7x734jcPnVRfRMzTjdXfgEzV9dHDw
         VQWQ==
X-Gm-Message-State: ANoB5pnB2PWS47lMeGZlR9yVj8K34hwfwHjTXp/QTHQcFVRO4bi8QUgn
        M3u1+1Y6FnTQW64S4aawmG5ZOrqcUOenmIFh+NA=
X-Google-Smtp-Source: AA0mqf5tc7bNIgeuFHkQqU719aWTrcQrM20X7WdXXDQGdO03e6vO+dv2nwY3yXKPlsstKSHrV6027y53D9oYOqzValc=
X-Received: by 2002:a17:90a:d681:b0:213:d08f:a455 with SMTP id
 x1-20020a17090ad68100b00213d08fa455mr111906052pju.130.1670844169397; Mon, 12
 Dec 2022 03:22:49 -0800 (PST)
MIME-Version: 1.0
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
From:   Xingyuan Mo <hdthky0@gmail.com>
Date:   Mon, 12 Dec 2022 19:22:38 +0800
Message-ID: <CALV6CNOO-Ppv7QfqHo9RKivv-1NUrezbuYN2krrNu4REuchtMA@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org, kolga@netapp.com,
        linux-nfs@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Can I share the patch with the linux-distros list, so that
distros can do their own testing and preparations?

Regards,
Xingyuan Mo

On Mon, Dec 12, 2022 at 3:22 AM Dai Ngo <dai.ngo@oracle.com> wrote:
>
> Problem caused by source's vfsmount being unmounted but remains
> on the delayed unmount list. This happens when nfs42_ssc_open()
> return errors.
> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
> for the laundromat to unmount when idle time expires.
>
> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 8beb2bc4c328..756e42cf0d01 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1463,13 +1463,6 @@ nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
>         return status;
>  }
>
> -static void
> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> -{
> -       nfs_do_sb_deactive(ss_mnt->mnt_sb);
> -       mntput(ss_mnt);
> -}
> -
>  /*
>   * Verify COPY destination stateid.
>   *
> @@ -1572,11 +1565,6 @@ nfsd4_cleanup_inter_ssc(struct vfsmount *ss_mnt, struct file *filp,
>  {
>  }
>
> -static void
> -nfsd4_interssc_disconnect(struct vfsmount *ss_mnt)
> -{
> -}
> -
>  static struct file *nfs42_ssc_open(struct vfsmount *ss_mnt,
>                                    struct nfs_fh *src_fh,
>                                    nfs4_stateid *stateid)
> @@ -1762,7 +1750,8 @@ static int nfsd4_do_async_copy(void *data)
>                 struct file *filp;
>
>                 filp = nfs42_ssc_open(copy->ss_mnt, &copy->c_fh,
> -                                     &copy->stateid);
> +                                       &copy->stateid);
> +
>                 if (IS_ERR(filp)) {
>                         switch (PTR_ERR(filp)) {
>                         case -EBADF:
> @@ -1771,7 +1760,7 @@ static int nfsd4_do_async_copy(void *data)
>                         default:
>                                 nfserr = nfserr_offload_denied;
>                         }
> -                       nfsd4_interssc_disconnect(copy->ss_mnt);
> +                       /* ss_mnt will be unmounted by the laundromat */
>                         goto do_callback;
>                 }
>                 nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
> @@ -1852,8 +1841,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>         if (async_copy)
>                 cleanup_async_copy(async_copy);
>         status = nfserrno(-ENOMEM);
> -       if (nfsd4_ssc_is_inter(copy))
> -               nfsd4_interssc_disconnect(copy->ss_mnt);
> +       /*
> +        * source's vfsmount of inter-copy will be unmounted
> +        * by the laundromat
> +        */
>         goto out;
>  }
>
> --
> 2.9.5
>
