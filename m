Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0652464AE51
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Dec 2022 04:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiLMDjX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 22:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiLMDjM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 22:39:12 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABA31DF34
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 19:39:11 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id a14so1342600pfa.1
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 19:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xwQXVE+nXDqH2Lx2FgAJSgMxuQHXalubs/iv+O2r5qE=;
        b=OUtj1SDh2AqmtMqT/kRHGr8CTizBJNTPkRbxsiRoYlIa50nghGA5bP7n1eij8/nYAZ
         616wt1En5cQTyxrwhIjNcTygddtpOxQYd316fV94TnRfwYiYzv+d3O40waY0YFoxWXyb
         5PqpJkgOygQ3xJaxAVKtvgUH2mchDmkBBJ1cz6+OvPmIrhUh24ORjEFPfy4y+KTu89iU
         SbkbPO/KyjhHXUumLilDsElaXPNYAyv7Ku3d7pGGvRnkQ+wEs/QzA/dr+dNq6DGBCdYL
         +AwqJpLMVNx7FeZ7byctjGL42fJCm1ZUkTNiSV4peHkusaB+NKxPqeLnxmmP036X04QN
         5Z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwQXVE+nXDqH2Lx2FgAJSgMxuQHXalubs/iv+O2r5qE=;
        b=BWz1rJ5Zoj6W/SneW8c3FMF5YDtULoOBaq7GeektVrmsMC9D4jjdkjtENpYS+gRWlo
         me9EvKWOTXP4wKpx2X61Cwrx+BAi6wEUPcPxnHT61YaUNdT+oSuL+gJ8k/DNiiMchMye
         +bHPEc2n943h4IiQhhKf5l2ZoFZDHj8ZfHoBKf/sz/0HSciEwfMSOd9YhwEBcyOOAs0m
         R9W+wzHie8D8DC7DcAC6qlHpYW3yjeplox4/Y1rlpO4Un6OLgqS1jmMXIM5npfOqy1HY
         0iP3dVndW0D1AV0HrdvcSQ2XzUkj5uroetUI0KMW/2GgBG1ZNp41lWHops5bcRCr6Udp
         Ybaw==
X-Gm-Message-State: ANoB5pnJmdiTAuBKjHYrmzRgxU4QUvnYPpKq9cAzAa75xeepx24dEabf
        4cu5M0Cgb5t1XRTbNo3PaSQ7+KYTxvsnYKPCN2Y=
X-Google-Smtp-Source: AA0mqf7sEkqGjaZbwNh+rzmB4kSnwvfjc4QkKzOYuMYOq8K2advIxxwk08U89yCMMZrPAbcMdnIQqnn0H5owOitKvMQ=
X-Received: by 2002:a05:6a02:10d:b0:477:931a:c811 with SMTP id
 bg13-20020a056a02010d00b00477931ac811mr69418429pgb.448.1670902750911; Mon, 12
 Dec 2022 19:39:10 -0800 (PST)
MIME-Version: 1.0
References: <1670885411-10060-1-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1670885411-10060-1-git-send-email-dai.ngo@oracle.com>
From:   Xingyuan Mo <hdthky0@gmail.com>
Date:   Tue, 13 Dec 2022 11:38:59 +0800
Message-ID: <CALV6CNPysKmTDmeZds61eKrtmA-yGbj1pQKvxOtfkpF3P5ankw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
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

On Tue, Dec 13, 2022 at 6:50 AM Dai Ngo <dai.ngo@oracle.com> wrote:
>
> Problem caused by source's vfsmount being unmounted but remains
> on the delayed unmount list. This happens when nfs42_ssc_open()
> return errors.
>
> Fixed by removing nfsd4_interssc_connect(), leave the vfsmount
> for the laundromat to unmount when idle time expires.
>
> We don't need to call nfs_do_sb_deactive when nfs42_ssc_open
> return errors since the file was not opened so nfs_server->active
> was not incremented. Same as in nfsd4_copy, if we fail to
> launch nfsd4_do_async_copy thread then there's no need to
> call nfs_do_sb_deactive
>
> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4proc.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 8beb2bc4c328..b79ee65ae016 100644
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
> @@ -1771,7 +1759,7 @@ static int nfsd4_do_async_copy(void *data)
>                         default:
>                                 nfserr = nfserr_offload_denied;
>                         }
> -                       nfsd4_interssc_disconnect(copy->ss_mnt);
> +                       /* ss_mnt will be unmounted by the laundromat */
>                         goto do_callback;
>                 }
>                 nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
> @@ -1852,8 +1840,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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

My test results show that this patch can fix the problem.

Regards,
Xingyuan Mo
