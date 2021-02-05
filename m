Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15575310C33
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Feb 2021 14:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhBENvx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Feb 2021 08:51:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231244AbhBENtZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Feb 2021 08:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612532878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FIFkNLl5v/SguqXZhdWO0Mq3LcGhxJ3ad0PNY2vLZXs=;
        b=KqSxYK4hIJyUtE+O/XxgRBuzBHbQyNteX0GRAXJa3DbTYGaFyUEE/P+6SUrf7ELGOXAZta
        xQdEvcVuMxHWSrCw5GWfQGZxykOxrpAlLuSj19nWStAZpCR82owaUNj83jMkG75W/fjLwf
        2+VfYvuaaVRrxE3GwLtr7LK9bTYvRsA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-2eoxVlOlOU21HGSijCpnaA-1; Fri, 05 Feb 2021 08:47:57 -0500
X-MC-Unique: 2eoxVlOlOU21HGSijCpnaA-1
Received: by mail-ed1-f69.google.com with SMTP id a26so7111180edx.8
        for <linux-nfs@vger.kernel.org>; Fri, 05 Feb 2021 05:47:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIFkNLl5v/SguqXZhdWO0Mq3LcGhxJ3ad0PNY2vLZXs=;
        b=ZCgKMTdjQ5ezlGQt45r9ELR39Mm0dFL1U7HE9o9MizAbnRN9hFhspBItGToQmgZ00g
         S4slRavmJ38awt8kd+cRbQOP4TktmDmrzwWqhJwn+TDFS3BnE4LQHyaKzglbwnqosMd/
         3UF3rSK+gBbjoI6M83KtGbEmIo+utTMjaxRxrBeagOMOn89M1ybTfkILEPvHfaY/fGKW
         Zwmg2gkVknWEuOX4LtclRll6B9IhhEWsDFHtaP0CPPf7NMHMnT8U3fg24g3gAiairvGA
         CLSkji2Yx+9aZx0/MZlgpo33ulzkQ0+LE2WnXPuIlehgafutyH5Pv0/y9gWcdXjFIPEK
         YDng==
X-Gm-Message-State: AOAM533/qD/GjVGgOS2faHzJiEGBZeST6Qeopd2NqziFm3RkGrTWN3zf
        6GxlqAvC3s0Fpqh8ND04a9wibKbUUB+SKCKqyPwH8Ll0dGTGhBPLX/kIO8tjq0yQ2CWjApN4HPB
        M7a59QYjU1coZOJB2D0BBCPoluHatPsIVxi6v
X-Received: by 2002:a17:906:4451:: with SMTP id i17mr3892184ejp.436.1612532875821;
        Fri, 05 Feb 2021 05:47:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzeGpRV2vJJ5W051147FRnZUQBu5RlIRJe9/rgIZGm/WhSCdWRX8rFJL1/bhPzFikbPTaFt2VFHr4f5DJ1Iic=
X-Received: by 2002:a17:906:4451:: with SMTP id i17mr3892177ejp.436.1612532875655;
 Fri, 05 Feb 2021 05:47:55 -0800 (PST)
MIME-Version: 1.0
References: <1611845708-6752-1-git-send-email-dwysocha@redhat.com> <1611845708-6752-7-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1611845708-6752-7-git-send-email-dwysocha@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 5 Feb 2021 08:47:19 -0500
Message-ID: <CALF+zOm=rnet4cXpSVs+7azC7P5W8oBgyu+NW8UCGeughCXi5A@mail.gmail.com>
Subject: Re: [PATCH 06/10] NFS: Allow internal use of read structs and functions
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 28, 2021 at 9:59 AM Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> The conversion of the NFS read paths to the new fscache API
> will require use of a few read structs and functions,
> so move these declarations as required.
>
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  fs/nfs/internal.h |  8 ++++++++
>  fs/nfs/read.c     | 13 ++++---------
>  2 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 62d3189745cd..8514d002c922 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -457,9 +457,17 @@ extern char *nfs_path(char **p, struct dentry *dentry,
>
>  struct nfs_pgio_completion_ops;
>  /* read.c */
> +extern const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
>  extern void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
>                         struct inode *inode, bool force_mds,
>                         const struct nfs_pgio_completion_ops *compl_ops);
> +struct nfs_readdesc {
> +       struct nfs_pageio_descriptor pgio;
> +       struct nfs_open_context *ctx;
> +};
> +extern int readpage_async_filler(void *data, struct page *page);
> +extern void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
> +                                    struct inode *inode);
>  extern void nfs_read_prepare(struct rpc_task *task, void *calldata);
>  extern void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio);
>
> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> index d2b6dce1f99f..9618abf01136 100644
> --- a/fs/nfs/read.c
> +++ b/fs/nfs/read.c
> @@ -30,7 +30,7 @@
>
>  #define NFSDBG_FACILITY                NFSDBG_PAGECACHE
>
> -static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
> +const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
>  static const struct nfs_rw_ops nfs_rw_read_ops;
>
>  static struct kmem_cache *nfs_rdata_cachep;
> @@ -74,7 +74,7 @@ void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
>  }
>  EXPORT_SYMBOL_GPL(nfs_pageio_init_read);
>
> -static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
> +void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
>                                      struct inode *inode)
>  {
>         struct nfs_pgio_mirror *pgm;
> @@ -132,11 +132,6 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
>         nfs_release_request(req);
>  }
>
> -struct nfs_readdesc {
> -       struct nfs_pageio_descriptor pgio;
> -       struct nfs_open_context *ctx;
> -};
> -
>  static void nfs_page_group_set_uptodate(struct nfs_page *req)
>  {
>         if (nfs_page_group_sync_on_bit(req, PG_UPTODATE))
> @@ -215,7 +210,7 @@ static void nfs_initiate_read(struct nfs_pgio_header *hdr,
>         }
>  }
>
> -static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
> +const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
>         .error_cleanup = nfs_async_read_error,
>         .completion = nfs_read_completion,
>  };
> @@ -290,7 +285,7 @@ static void nfs_readpage_result(struct rpc_task *task,
>                 nfs_readpage_retry(task, hdr);
>  }
>
> -static int
> +int
>  readpage_async_filler(void *data, struct page *page)
>  {
>         struct nfs_readdesc *desc = data;
> --
> 1.8.3.1
>

Anna, FYI, you could drop this from your linux-next branch if you want.
Since the fscache conversion patches are not included, we don't really
need this patch.
The other patches 1-5 I are valid cleanups but this really goes with
the conversion patches.
It's your call though.

