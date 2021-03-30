Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8834EB60
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhC3O75 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Mar 2021 10:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhC3O7i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Mar 2021 10:59:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404EAC061762
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 07:59:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id jy13so25345246ejc.2
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ElRH3X9hP7YNzvrdl0ZOG9fxYXlWxv5o7mxHbBLYY4=;
        b=ErQm9W/IuGaWZYK3tRtd64ZN5gtzjhTtV1RrPJAIRAbE+kxxRniUWLt01UWUjr5yZK
         3eW2WhLGkethn7jmqneIgA0h7YQq+/VKP61naM0OGB1WrJEdVMFXZZ4ydAoB6Rd07nJe
         JXlHSR1+nJuU3LlCtMSAJFwDLAXL94aORE/V/63M079wObPiiwxkNTAz+Vzmrd1Jks3v
         +Qhu61L0B8d9we98+f/0FUtBDSdvaH72W51Nl9m2RMhQfMD6vjZRFD2JoPGmBqgv9sn2
         PC7D+UCqdV+AWTmtMCBvHgeOR5rz5BrgV60gXQlR55uZRyIanpE7DfZZ7S39Le5pEx6J
         gcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ElRH3X9hP7YNzvrdl0ZOG9fxYXlWxv5o7mxHbBLYY4=;
        b=uUoDBxutDMVfFPRm+39LxPGZqT9R5yoS0SfOmiAyBLnXAv6+KEYdpW4/aDBcNBRopo
         XCOg19nvBVsh+pJYR+eTUSNNbkelNpOpIS5aNKgBOBriQQjh0OLm22CDMCGehiywOREn
         mMRXQ884CT73yZPrBcrn3hHnzi4CyxFye2vRWUhVAPvfQxIqJPVPAToR40gt294BE83w
         Hh8TgvIn5nX4fz/4b+K4i+wprofIN6U6/Ix1ohLhgsZ6mR9h0IdCmPOEfC1UlLHWv8Zy
         heds+O7i+cPHx8h4Q8dkYBUOQ5tkktgqUphgup5MRmVUKqDu3LzlGCDk5IQIQR/6tDZi
         24cw==
X-Gm-Message-State: AOAM5300p/9TQEaiu4qa81mafhG9bO6mEMggZlCcpo1LwSklvmCZsz9O
        ou2V5ywwKxgMKwTo4AObEsArb3hlJdUQUlrDI38=
X-Google-Smtp-Source: ABdhPJyPrFAMyazMjLtW1KqD9EgBd7DsBFepKUEWHrFuhkig4P8d0OFUAkQD8uFEc0DZGttc0oOExxSPG5JHRjF9SrE=
X-Received: by 2002:a17:906:e84:: with SMTP id p4mr33521760ejf.248.1617116375865;
 Tue, 30 Mar 2021 07:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210330134010.61313-1-trondmy@kernel.org>
In-Reply-To: <20210330134010.61313-1-trondmy@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 30 Mar 2021 10:59:24 -0400
Message-ID: <CAN-5tyE5XxKhQ-mzmtidv1ZPtU19dCUCwWu8SUgqjq6cMTq2pQ@mail.gmail.com>
Subject: Re: [PATCH] NFS: Fix up the support for CONFIG_NFS_DISABLE_UDP_SUPPORT
To:     trondmy@kernel.org
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        Eryu Guan <eguan@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 30, 2021 at 9:41 AM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Rather than removing the support in nfs_init_timeout_values(), we should
> just fix up the validation checks in the mount option parsers.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

With this patch, on top of the existing patches I tested that I no
longer see an oops while mounting with v3  (and yes in my kernel
config I have DISABLE_UDP enabled).

> ---
>  fs/nfs/client.c     |  2 --
>  fs/nfs/fs_context.c | 54 +++++++++++++++++++++++++++++----------------
>  2 files changed, 35 insertions(+), 21 deletions(-)
>
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 94d47be1d1f6..2aeb4e52a4f1 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -476,7 +476,6 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
>                         to->to_maxval = to->to_initval;
>                 to->to_exponential = 0;
>                 break;
> -#ifndef CONFIG_NFS_DISABLE_UDP_SUPPORT
>         case XPRT_TRANSPORT_UDP:
>                 if (retrans == NFS_UNSPEC_RETRANS)
>                         to->to_retries = NFS_DEF_UDP_RETRANS;
> @@ -487,7 +486,6 @@ void nfs_init_timeout_values(struct rpc_timeout *to, int proto,
>                 to->to_maxval = NFS_MAX_UDP_TIMEOUT;
>                 to->to_exponential = 1;
>                 break;
> -#endif
>         default:
>                 BUG();
>         }
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 902db1262d2b..cdf32b9a6c35 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -283,20 +283,40 @@ static int nfs_verify_server_address(struct sockaddr *addr)
>         return 0;
>  }
>
> +#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
> +static bool nfs_server_transport_udp_invalid(const struct nfs_fs_context *ctx)
> +{
> +       return true;
> +}
> +#else
> +static bool nfs_server_transport_udp_invalid(const struct nfs_fs_context *ctx)
> +{
> +       if (ctx->version == 4)
> +               return true;
> +       return false;
> +}
> +#endif
> +
>  /*
>   * Sanity check the NFS transport protocol.
> - *
>   */
> -static void nfs_validate_transport_protocol(struct nfs_fs_context *ctx)
> +static int nfs_validate_transport_protocol(struct fs_context *fc,
> +                                          struct nfs_fs_context *ctx)
>  {
>         switch (ctx->nfs_server.protocol) {
>         case XPRT_TRANSPORT_UDP:
> +               if (nfs_server_transport_udp_invalid(ctx))
> +                       goto out_invalid_transport_udp;
> +               break;
>         case XPRT_TRANSPORT_TCP:
>         case XPRT_TRANSPORT_RDMA:
>                 break;
>         default:
>                 ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
>         }
> +       return 0;
> +out_invalid_transport_udp:
> +       return nfs_invalf(fc, "NFS: Unsupported transport protocol udp");
>  }
>
>  /*
> @@ -305,8 +325,6 @@ static void nfs_validate_transport_protocol(struct nfs_fs_context *ctx)
>   */
>  static void nfs_set_mount_transport_protocol(struct nfs_fs_context *ctx)
>  {
> -       nfs_validate_transport_protocol(ctx);
> -
>         if (ctx->mount_server.protocol == XPRT_TRANSPORT_UDP ||
>             ctx->mount_server.protocol == XPRT_TRANSPORT_TCP)
>                         return;
> @@ -929,6 +947,7 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
>         struct nfs_fh *mntfh = ctx->mntfh;
>         struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
>         int extra_flags = NFS_MOUNT_LEGACY_INTERFACE;
> +       int ret;
>
>         if (data == NULL)
>                 goto out_no_data;
> @@ -1054,6 +1073,10 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
>                 goto generic;
>         }
>
> +       ret = nfs_validate_transport_protocol(fc, ctx);
> +       if (ret)
> +               return ret;
> +
>         ctx->skip_reconfig_option_check = true;
>         return 0;
>
> @@ -1155,6 +1178,7 @@ static int nfs4_parse_monolithic(struct fs_context *fc,
>  {
>         struct nfs_fs_context *ctx = nfs_fc2context(fc);
>         struct sockaddr *sap = (struct sockaddr *)&ctx->nfs_server.address;
> +       int ret;
>         char *c;
>
>         if (!data) {
> @@ -1227,9 +1251,9 @@ static int nfs4_parse_monolithic(struct fs_context *fc,
>         ctx->acdirmin   = data->acdirmin;
>         ctx->acdirmax   = data->acdirmax;
>         ctx->nfs_server.protocol = data->proto;
> -       nfs_validate_transport_protocol(ctx);
> -       if (ctx->nfs_server.protocol == XPRT_TRANSPORT_UDP)
> -               goto out_invalid_transport_udp;
> +       ret = nfs_validate_transport_protocol(fc, ctx);
> +       if (ret)
> +               return ret;
>  done:
>         ctx->skip_reconfig_option_check = true;
>         return 0;
> @@ -1240,9 +1264,6 @@ static int nfs4_parse_monolithic(struct fs_context *fc,
>
>  out_no_address:
>         return nfs_invalf(fc, "NFS4: mount program didn't pass remote address");
> -
> -out_invalid_transport_udp:
> -       return nfs_invalf(fc, "NFS: Unsupported transport protocol udp");
>  }
>  #endif
>
> @@ -1307,6 +1328,10 @@ static int nfs_fs_context_validate(struct fs_context *fc)
>         if (!nfs_verify_server_address(sap))
>                 goto out_no_address;
>
> +       ret = nfs_validate_transport_protocol(fc, ctx);
> +       if (ret)
> +               return ret;
> +
>         if (ctx->version == 4) {
>                 if (IS_ENABLED(CONFIG_NFS_V4)) {
>                         if (ctx->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
> @@ -1315,9 +1340,6 @@ static int nfs_fs_context_validate(struct fs_context *fc)
>                                 port = NFS_PORT;
>                         max_namelen = NFS4_MAXNAMLEN;
>                         max_pathlen = NFS4_MAXPATHLEN;
> -                       nfs_validate_transport_protocol(ctx);
> -                       if (ctx->nfs_server.protocol == XPRT_TRANSPORT_UDP)
> -                               goto out_invalid_transport_udp;
>                         ctx->flags &= ~(NFS_MOUNT_NONLM | NFS_MOUNT_NOACL |
>                                         NFS_MOUNT_VER3 | NFS_MOUNT_LOCAL_FLOCK |
>                                         NFS_MOUNT_LOCAL_FCNTL);
> @@ -1326,10 +1348,6 @@ static int nfs_fs_context_validate(struct fs_context *fc)
>                 }
>         } else {
>                 nfs_set_mount_transport_protocol(ctx);
> -#ifdef CONFIG_NFS_DISABLE_UDP_SUPPORT
> -              if (ctx->nfs_server.protocol == XPRT_TRANSPORT_UDP)
> -                      goto out_invalid_transport_udp;
> -#endif
>                 if (ctx->nfs_server.protocol == XPRT_TRANSPORT_RDMA)
>                         port = NFS_RDMA_PORT;
>         }
> @@ -1363,8 +1381,6 @@ static int nfs_fs_context_validate(struct fs_context *fc)
>  out_v4_not_compiled:
>         nfs_errorf(fc, "NFS: NFSv4 is not compiled into kernel");
>         return -EPROTONOSUPPORT;
> -out_invalid_transport_udp:
> -       return nfs_invalf(fc, "NFS: Unsupported transport protocol udp");
>  out_no_address:
>         return nfs_invalf(fc, "NFS: mount program didn't pass remote address");
>  out_mountproto_mismatch:
> --
> 2.30.2
>
