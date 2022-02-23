Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB354C2051
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 00:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbiBWX4D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 18:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiBWX4C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 18:56:02 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB1D5DE4B
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 15:55:33 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bg10so769653ejb.4
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 15:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nxVI/2uRa+9HOkFVRn+mxMDfkNFWjA0r1lzU26HgWc=;
        b=F7cHrRgMVbn2a6ribFAPxu0YtOU4c1oKVOHnN2+/Tg2A2aLkATCIbsNU/GDlJz849K
         yXC+lppjt609j+IxwUZhwedIBBe3/7aRFcNn5kwiCSY9ziENOb+WU0FlfHEfHK13Nk5x
         ybBRVYM2/NEtZswS1pX9gvIM0Ucl6HhVL4+dh3MxeoV0ESJ1+XM1v7d+4MgC3/P/uWjL
         QZDNyfmh87LfPkLdLXR31btmnkEn+HD5kchZ7P1DVLR551J0b+CCW5gC8s8Vw3I0fi+r
         RWsskzOP+xnaEN4I+fVJiVGjtEa3lcDU1DXszUx87lgIkJJZB3WKzgtSTw17LaSz2tQz
         T1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nxVI/2uRa+9HOkFVRn+mxMDfkNFWjA0r1lzU26HgWc=;
        b=AS4wmVNOMuulfH9Sk/Ucee29rEXK4izFrCiuNRFyR4LxlJpNjeBpgim9F6maISe4Kj
         PBqtuh5+55Z4QCJv4PoOVgstmNZiEnJUm+swqzQfmjeBHDA+WYaeMWztROU4MtggmpTa
         RaUC56XaG8gpjOxnCr+NrOqqzDeK6l0mJr1qa4VjMzKdoBsQ2w/at6lz61g6Oa0Dy1lm
         P0IwThDvYbN4kg1W9kV6ME/M81b2sPBjeGe48EE2NS05ELyYMoUZAcMoYCI15cd8zMdp
         kXXL4uxIjF83cojP1/44SsFc+/QUh8r4qjYUlFj4Qw958RjQ/qH7ppKEQkJvRklN0gy0
         KX/g==
X-Gm-Message-State: AOAM531aqqi+/072CA0I9Bb23ALed1SggWTcz/BOXvHVLFrx/c8mCMkO
        ejfjqDk8klmlU5mcnZECvFpwGQX3VknEVO0QZnyNCiYo
X-Google-Smtp-Source: ABdhPJzcSmC0mEeRBY5KhuigSdk62S7EKQX76iXAx/Dk7mUNNuXQLR4BJDIki31aU6AivWlADayFRhBr1lRNNkQNjrs=
X-Received: by 2002:a17:906:2991:b0:6cc:fc18:f10c with SMTP id
 x17-20020a170906299100b006ccfc18f10cmr98969eje.744.1645660531918; Wed, 23 Feb
 2022 15:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20220223174041.77887-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20220223174041.77887-1-olga.kornievskaia@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 23 Feb 2022 18:55:20 -0500
Message-ID: <CAN-5tyHy_+tBfv3PuD0CBwHbppHo3pRNwo0O9xRGjZxK0-rOjw@mail.gmail.com>
Subject: Re: [PATCH v1] NFSv4.1 provide mount option to toggle trunking discovery
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Kurt Garloff <kurt@garloff.de>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I have forgotten to cc Kurt Garloff to the post.

On Wed, Feb 23, 2022 at 12:40 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Introduce a new mount option -- trunkdiscovery,notrunkdiscovery -- to
> toggle whether or not the client will engage in actively discovery
> of trunking locations.
>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/client.c           | 3 ++-
>  fs/nfs/fs_context.c       | 8 ++++++++
>  include/linux/nfs_fs_sb.h | 1 +
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index d1f34229e11a..84c080ddfd01 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -857,7 +857,8 @@ static int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, str
>         }
>
>         if (clp->rpc_ops->discover_trunking != NULL &&
> -                       (server->caps & NFS_CAP_FS_LOCATIONS)) {
> +                       (server->caps & NFS_CAP_FS_LOCATIONS &&
> +                        !(server->flags & NFS_MOUNT_NOTRUNK_DISCOVERY))) {
>                 error = clp->rpc_ops->discover_trunking(server, mntfh);
>                 if (error < 0)
>                         return error;
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index ea17fa1f31ec..ad1448a63aa0 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -80,6 +80,7 @@ enum nfs_param {
>         Opt_source,
>         Opt_tcp,
>         Opt_timeo,
> +       Opt_trunkdiscovery,
>         Opt_udp,
>         Opt_v,
>         Opt_vers,
> @@ -180,6 +181,7 @@ static const struct fs_parameter_spec nfs_fs_parameters[] = {
>         fsparam_string("source",        Opt_source),
>         fsparam_flag  ("tcp",           Opt_tcp),
>         fsparam_u32   ("timeo",         Opt_timeo),
> +       fsparam_flag_no("trunkdiscovery", Opt_trunkdiscovery),
>         fsparam_flag  ("udp",           Opt_udp),
>         fsparam_flag  ("v2",            Opt_v),
>         fsparam_flag  ("v3",            Opt_v),
> @@ -529,6 +531,12 @@ static int nfs_fs_context_parse_param(struct fs_context *fc,
>                 else
>                         ctx->flags &= ~NFS_MOUNT_NOCTO;
>                 break;
> +       case Opt_trunkdiscovery:
> +               if (result.negated)
> +                       ctx->flags |= NFS_MOUNT_NOTRUNK_DISCOVERY;
> +               else
> +                       ctx->flags &= ~NFS_MOUNT_NOTRUNK_DISCOVERY;
> +               break;
>         case Opt_ac:
>                 if (result.negated)
>                         ctx->flags |= NFS_MOUNT_NOAC;
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index ca0959e51e81..d0920d7f5f9e 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -151,6 +151,7 @@ struct nfs_server {
>  #define NFS_MOUNT_SOFTREVAL            0x800000
>  #define NFS_MOUNT_WRITE_EAGER          0x01000000
>  #define NFS_MOUNT_WRITE_WAIT           0x02000000
> +#define NFS_MOUNT_NOTRUNK_DISCOVERY    0x04000000
>
>         unsigned int            fattr_valid;    /* Valid attributes */
>         unsigned int            caps;           /* server capabilities */
> --
> 2.27.0
>
