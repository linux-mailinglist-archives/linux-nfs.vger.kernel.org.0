Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B32D2A89FC
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 23:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgKEWhp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 17:37:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732250AbgKEWhp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 17:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604615863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xuDV0hV2Tn43pTJUiwiMZbxhnhM/1eaGdD9lKhf+xtk=;
        b=I66iJ0x/2xZrvA84JhunY6sFz/rwfpWs1Y0hW4PyjTJnbvqZpuWhafHuLRIci64VXIASFW
        6wGt6rzfOl0YYrS7IdX6tFAdp0B1IsUU3sojWAxYOPGV2I00lZ7VeVSB/EENsDtHE8JAXe
        My/orw30UDD7h9Yn18FVSgvEhFS05Ac=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-Esy_uLJ3PH68FBTfPHc2YQ-1; Thu, 05 Nov 2020 17:37:40 -0500
X-MC-Unique: Esy_uLJ3PH68FBTfPHc2YQ-1
Received: by mail-lf1-f72.google.com with SMTP id e29so1214191lfb.5
        for <linux-nfs@vger.kernel.org>; Thu, 05 Nov 2020 14:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xuDV0hV2Tn43pTJUiwiMZbxhnhM/1eaGdD9lKhf+xtk=;
        b=IOIPwO8JRzh9CKpgEK/UviydixW/9Q+66Wpv6eHV08aFZp6HYq20cWpvgAxtAR7v8t
         eNFQiMEGf9U+81ZZr7CMK491IWxALhSZMoOXlAfIhku3xNNRnoDw6w07HLuMkawdwkH2
         DTAHzSRyNoNUGS1AswyfXdOQgNX3bVx28MivqwpEOqgLWzfb9bDF3fWOxIBawbbR8Lu2
         37z+kE8f65hNGP9fJ4xkctlIZYXNwiGjdbNbSevZOpjHq1IyCkmFXQ1ByKXH+kYfhmAP
         8aH4hY/X1/FODpSJILBM0jIhvDuCx9cBCqT6smh+ph7AOny6JSxYJnRAAbEtn0xpLEQc
         GGyQ==
X-Gm-Message-State: AOAM531oV9n8qsNnrnRbRVke9HiHEliOi9l4X6R7+aq2DCeMVCJVRvvN
        hs/XuEUdGqVqDQ0lMq6CRMZD8gFnGaOTQvomEYZ0g30j0MjPHqXuGHw0v9mB8VkZ+9Zb9O+WMzd
        8P8nFGnPZ7A2y6DEc+l93160xHgcwsH8cYHYs
X-Received: by 2002:a2e:8145:: with SMTP id t5mr1754926ljg.311.1604615858900;
        Thu, 05 Nov 2020 14:37:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKYiLWqWVa4I9lar0Wkdhp6YH9BlOn+Bbu0cECL6pFFVMj6d2YiN8wjlNtYXClMatRPsYFaIiZ4XI/eVFu24Q=
X-Received: by 2002:a2e:8145:: with SMTP id t5mr1754917ljg.311.1604615858645;
 Thu, 05 Nov 2020 14:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20201105221245.2838-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20201105221245.2838-1-olga.kornievskaia@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 5 Nov 2020 23:37:27 +0100
Message-ID: <CAFqZXNtJ2fkae7Xt-+nDR79kVs=yY=9vSoZaS-V-5UKSk22s4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] NFSv4.2: condition READDIR's mask for security
 label based on LSM state
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 5, 2020 at 11:12 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Currently, the client will always ask for security_labels if the server
> returns that it supports that feature regardless of any LSM modules
> (such as Selinux) enforcing security policy. This adds performance
> penalty to the READDIR operation.
>
> Client adjusts the superblock's support of the security_label based on
> the server's support but also on the current client's configuration of
> the LSM module(s). Thus, prior to using the default bitmask in READDIR,
> this patch checks the server's capabilities and then instructs
> READDIR to remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.
>
> v2: dropping selinux hook and using the sb cap.

Thanks! I'm happy that we managed to avoid adding yet another LSM hook
in the end :)

>
> Suggested-by: Ondrej Mosnacek <omosnace@redhat.com
> Suggested-by: Scott Mayhew <smayhew@redhat.com>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs4proc.c       | 3 +++
>  fs/nfs/nfs4xdr.c        | 3 ++-
>  include/linux/nfs_xdr.h | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 9e0ca9b2b210..9c9d9aa2a8f8 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -4968,6 +4968,7 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
>                 .count = count,
>                 .bitmask = NFS_SERVER(d_inode(dentry))->attr_bitmask,
>                 .plus = plus,
> +               .labels = true,
>         };
>         struct nfs4_readdir_res res;
>         struct rpc_message msg = {
> @@ -4981,6 +4982,8 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
>         dprintk("%s: dentry = %pd2, cookie = %Lu\n", __func__,
>                         dentry,
>                         (unsigned long long)cookie);
> +       if (!(NFS_SB(dentry->d_sb)->caps & NFS_CAP_SECURITY_LABEL))
> +               args.labels = false;

Minor nit: you could initialize .labels directly in the initializer of
"args" like this:

.labels = !!(NFS_SB(dentry->d_sb)->caps & NFS_CAP_SECURITY_LABEL),

>         nfs4_setup_readdir(cookie, NFS_I(dir)->cookieverf, dentry, &args);
>         res.pgbase = args.pgbase;
>         status = nfs4_call_sync(NFS_SERVER(dir)->client, NFS_SERVER(dir), &msg, &args.seq_args, &res.seq_res, 0);
> diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> index c6dbfcae7517..585d5b5cc3dc 100644
> --- a/fs/nfs/nfs4xdr.c
> +++ b/fs/nfs/nfs4xdr.c
> @@ -1605,7 +1605,8 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
>                         FATTR4_WORD1_OWNER_GROUP|FATTR4_WORD1_RAWDEV|
>                         FATTR4_WORD1_SPACE_USED|FATTR4_WORD1_TIME_ACCESS|
>                         FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
> -               attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
> +               if (readdir->labels)
> +                       attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
>                 dircount >>= 1;
>         }
>         /* Use mounted_on_fileid only if the server supports it */
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index d63cb862d58e..95f648b26525 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1119,6 +1119,7 @@ struct nfs4_readdir_arg {
>         unsigned int                    pgbase; /* zero-copy data */
>         const u32 *                     bitmask;
>         bool                            plus;
> +       bool                            labels;
>  };
>
>  struct nfs4_readdir_res {
> --
> 2.18.2
>

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

