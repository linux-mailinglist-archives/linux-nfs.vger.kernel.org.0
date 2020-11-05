Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF762A867C
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 19:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKESzm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 13:55:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728137AbgKESzm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 13:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604602541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D1JX91vyX0RMOSkxWirey7PqVagR00j9ZCCAeF7MViU=;
        b=H1zSVUmHQISbVpxLwNwxkJuvuckObB/tqG4Ova0xgXWuZQUO3Y5nsLvz8jMhEGRnXpzL77
        BOOWh7FJj5NQADUOQNjiWQwuLxlrRXFFz8N8EFuNt0qP3qIqfRS8t+DhpcCKafVyX5bjIK
        u7fJavvPjpUQPb+H4CxAmYyclOuKdQ4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-8WzwEmzJOnKsz-CQYHbxJA-1; Thu, 05 Nov 2020 13:55:36 -0500
X-MC-Unique: 8WzwEmzJOnKsz-CQYHbxJA-1
Received: by mail-ed1-f69.google.com with SMTP id t7so910270edt.0
        for <linux-nfs@vger.kernel.org>; Thu, 05 Nov 2020 10:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1JX91vyX0RMOSkxWirey7PqVagR00j9ZCCAeF7MViU=;
        b=LXXFTdiZxE3MEyb3mdyEvheRrOJw7RUikhZCW8GTFuIbsTFDhli2mq37AY002HT3Lu
         Sc75j8xyK6RUF28yb/f6KIybXgN+vm1sPaTMpIFBjEFYhDZbXrz/6/bgJ0ZTA9UzdqTn
         Dq9VWQdzsjPqMf6wZOl1b7g5Wsa1Lxzv1AuSEUXCrDVAgt6aXUsvU84ebt08hMl56VWn
         PoXZorE1PYmVH6sMdTl2sIeCgBNwepYgdT9NLMzZyD9h56j0Dpz6ggByhRnbu4qFbpTN
         rT3StJDCbNj/BE5HSVkOX+ZlLqRsISMRZ77+a1claLhoHZxT2lWEue6H5uQzTQPd2CJ9
         Wpaw==
X-Gm-Message-State: AOAM531wMALfcOLaoL8xwysDfz4DXT8jgQev16Jj13xWPUgdZ24N6Ujn
        /0755wbmgNVmTQdxrRJvz/824xFn9iJEy65jYSzGh6D6C7PYfqczYrRdQ/60rnFxaY//r96Sd38
        RgP/LJpCwQ/VKM8Dm4K1PzXySg3IBslGKqidG
X-Received: by 2002:a50:cc48:: with SMTP id n8mr4234057edi.137.1604602534872;
        Thu, 05 Nov 2020 10:55:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOXq6TzFUWqo6exDgAAPj905PARZ/K8l6nKjmXIQeFt7uFPr3bqyHlefLfvjruhGYqgEaSuddfh2+AsqQlahU=
X-Received: by 2002:a50:cc48:: with SMTP id n8mr4234039edi.137.1604602534585;
 Thu, 05 Nov 2020 10:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20201105173328.2539-1-olga.kornievskaia@gmail.com> <20201105173328.2539-2-olga.kornievskaia@gmail.com>
In-Reply-To: <20201105173328.2539-2-olga.kornievskaia@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 5 Nov 2020 19:55:23 +0100
Message-ID: <CAFqZXNtjMEF0LO4vtEmcgwydbWfUS36d8g24J6C-NDXORYbEJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFSv4.2: condition READDIR's mask for security label
 based on LSM state
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-nfs@vger.kernel.org,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 5, 2020 at 6:33 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
> From: Olga Kornievskaia <kolga@netapp.com>
>
> Currently, the client will always ask for security_labels if the server
> returns that it supports that feature regardless of any LSM modules
> (such as Selinux) enforcing security policy. This adds performance
> penalty to the READDIR operation.
>
> Instead, query the LSM module to find if anything is enabled and
> if not, then remove FATTR4_WORD2_SECURITY_LABEL from the bitmask.

Having spent some time staring at some of the NFS code very recently,
I can't help but suggest: Would it perhaps be enough to decide whether
to ask for labels based on (NFS_SB(dentry->d_sb)->caps &
NFS_CAP_SECURITY_LABEL)? It is set when mounting the FS iff some LSM
confirms via the security_sb_*_mnt_opts() hook that it wants the
filesystem to give it labels (or at least that's how I interpret the
cryptic name) [1]. It's just a shot in the dark, but it seems to fit
this use case.

[1] https://elixir.bootlin.com/linux/v5.10-rc2/source/fs/nfs/getroot.c#L148

>
> Suggested-by: Scott Mayhew <smayhew@redhat.com>
> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> ---
>  fs/nfs/nfs4proc.c       | 5 +++++
>  fs/nfs/nfs4xdr.c        | 3 ++-
>  include/linux/nfs_xdr.h | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 9e0ca9b2b210..774bc5e63ca7 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -55,6 +55,7 @@
>  #include <linux/utsname.h>
>  #include <linux/freezer.h>
>  #include <linux/iversion.h>
> +#include <linux/security.h>
>
>  #include "nfs4_fs.h"
>  #include "delegation.h"
> @@ -4968,6 +4969,7 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
>                 .count = count,
>                 .bitmask = NFS_SERVER(d_inode(dentry))->attr_bitmask,
>                 .plus = plus,
> +               .labels = true,
>         };
>         struct nfs4_readdir_res res;
>         struct rpc_message msg = {
> @@ -4977,10 +4979,13 @@ static int _nfs4_proc_readdir(struct dentry *dentry, const struct cred *cred,
>                 .rpc_cred = cred,
>         };
>         int                     status;
> +       int sec_flags = LSM_FQUERY_VFS_XATTRS;
>
>         dprintk("%s: dentry = %pd2, cookie = %Lu\n", __func__,
>                         dentry,
>                         (unsigned long long)cookie);
> +       if (!security_func_query_vfs(sec_flags))
> +               args.labels = false;
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

