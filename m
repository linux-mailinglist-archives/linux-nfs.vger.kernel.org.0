Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90E747C929
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 23:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbhLUWVG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 17:21:06 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:42900 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhLUWVG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 17:21:06 -0500
Received: by mail-yb1-f173.google.com with SMTP id j2so575546ybg.9
        for <linux-nfs@vger.kernel.org>; Tue, 21 Dec 2021 14:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oimRxhiLTYUc6/+2MFBZQWGYZ/3nnwSlnAB3pFu8C5s=;
        b=WKhFUMNcj6Z7mHYLLiX3JkMd1xfQWqOsbaLeOemR2Yw+BKIOZbRLxK3lt3/HqooqvN
         EimTchAibc/lyMInZcoExw4hm7ElKhG1KtWHDHw2N/Vxb9v68UDx0sIqmwOMhX8IxKl8
         0tZ0XNOhZ6+f+U+f5fYqc1Z6q892QpRXfEQ74Oarb2ljbGBs1HQjq/2ThbL35uQxsyfF
         Bv/yJUxSbRwewbUNplLUdyRxJ2L/Eobj969QWEqATvSgU8ohhiQdwMG/mzF3755OZGub
         UZdtLxfvzDCg2uCkn3nf9LsZ3Mu5DpJt+juEq6XlefyVr/nqWM4LmjbdyNsEnhu4pHTQ
         1bQQ==
X-Gm-Message-State: AOAM531cjXe51gBZa6MHqkEEEEm3c9BG8QQMuQxA3yDhAfKKt6TAxxb3
        DSRuYjJow+srtKjEYZol7BJPHqAvsOgjWwyeNyxPRRIa
X-Google-Smtp-Source: ABdhPJz0Fh6Co0wSYm5iYqSHppFyPmksMC92kSI9OEfJ5EmzxnW3wmBCR1+vKWqwdsGKTKWhvG0TLz5CvjXC+Nblhts=
X-Received: by 2002:a25:b9c7:: with SMTP id y7mr575121ybj.276.1640125265637;
 Tue, 21 Dec 2021 14:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20211217204854.439578-1-trondmy@kernel.org> <20211217204854.439578-2-trondmy@kernel.org>
 <20211217204854.439578-3-trondmy@kernel.org> <20211217204854.439578-4-trondmy@kernel.org>
 <20211217204854.439578-5-trondmy@kernel.org> <20211217204854.439578-6-trondmy@kernel.org>
 <20211217204854.439578-7-trondmy@kernel.org> <20211217204854.439578-8-trondmy@kernel.org>
 <20211217204854.439578-9-trondmy@kernel.org>
In-Reply-To: <20211217204854.439578-9-trondmy@kernel.org>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Tue, 21 Dec 2021 17:20:49 -0500
Message-ID: <CAFX2JfnQ30pZaLmDEtZLszG87CD5L6rnDo+aY++3hWDfJL8mUA@mail.gmail.com>
Subject: Re: [PATCH 8/8] NFSv4: Add an ioctl to allow retrieval of the NFS raw
 ACCESS mask
To:     trondmy@kernel.org
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

On Fri, Dec 17, 2021 at 5:03 PM <trondmy@kernel.org> wrote:
>
> From: Trond Myklebust <trond.myklebust@hammerspace.com>

This patch conflicts with Neil Brown's cred cleanups. I did my best to
get it to apply, but then it didn't compile. Can you please rebase and
test on top of those patches, since they're already included in my
linux-next  branch?

Thanks,
Anna

>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c             | 47 +++++++++++++++++++++++++---------------
>  fs/nfs/internal.h        |  2 ++
>  fs/nfs/nfs4file.c        | 39 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/nfs.h | 11 ++++++++++
>  4 files changed, 81 insertions(+), 18 deletions(-)
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index f6fc60822153..2cbff76d36de 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2863,37 +2863,33 @@ void nfs_access_set_mask(struct nfs_access_entry *entry, u32 access_result)
>  }
>  EXPORT_SYMBOL_GPL(nfs_access_set_mask);
>
> -static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
> +int nfs_get_access(struct inode *inode, const struct cred *cred,
> +                  struct nfs_access_entry *cache, bool may_block)
>  {
> -       struct nfs_access_entry cache;
> -       bool may_block = (mask & MAY_NOT_BLOCK) == 0;
> -       int cache_mask = -1;
>         int status;
>
>         trace_nfs_access_enter(inode);
>
> -       status = nfs_access_get_cached(inode, cred, &cache, may_block);
> +       status = nfs_access_get_cached(inode, cred, cache, may_block);
>         if (status == 0)
> -               goto out_cached;
> +               return 0;
>
> -       status = -ECHILD;
>         if (!may_block)
> -               goto out;
> -
> +               return -ECHILD;
>         /*
>          * Determine which access bits we want to ask for...
>          */
> -       cache.mask = NFS_ACCESS_READ | NFS_ACCESS_MODIFY | NFS_ACCESS_EXTEND;
> +       cache->mask = NFS_ACCESS_READ | NFS_ACCESS_MODIFY | NFS_ACCESS_EXTEND;
>         if (nfs_server_capable(inode, NFS_CAP_XATTR)) {
> -               cache.mask |= NFS_ACCESS_XAREAD | NFS_ACCESS_XAWRITE |
> +               cache->mask |= NFS_ACCESS_XAREAD | NFS_ACCESS_XAWRITE |
>                     NFS_ACCESS_XALIST;
>         }
>         if (S_ISDIR(inode->i_mode))
> -               cache.mask |= NFS_ACCESS_DELETE | NFS_ACCESS_LOOKUP;
> +               cache->mask |= NFS_ACCESS_DELETE | NFS_ACCESS_LOOKUP;
>         else
> -               cache.mask |= NFS_ACCESS_EXECUTE;
> -       cache.cred = cred;
> -       status = NFS_PROTO(inode)->access(inode, &cache);
> +               cache->mask |= NFS_ACCESS_EXECUTE;
> +       cache->cred = cred;
> +       status = NFS_PROTO(inode)->access(inode, cache);
>         if (status != 0) {
>                 if (status == -ESTALE) {
>                         if (!S_ISDIR(inode->i_mode))
> @@ -2901,10 +2897,25 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
>                         else
>                                 nfs_zap_caches(inode);
>                 }
> -               goto out;
> +               return status;
>         }
> -       nfs_access_add_cache(inode, &cache);
> -out_cached:
> +       nfs_access_add_cache(inode, cache);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(nfs_get_access);
> +
> +static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
> +{
> +       struct nfs_access_entry cache;
> +       bool may_block = (mask & MAY_NOT_BLOCK) == 0;
> +       int cache_mask = -1;
> +       int status;
> +
> +       trace_nfs_access_enter(inode);
> +
> +       status = nfs_get_access(inode, cred, &cache, may_block);
> +       if (status < 0)
> +               goto out;
>         cache_mask = nfs_access_calc_mask(cache.mask, inode->i_mode);
>         if ((mask & ~cache_mask & (MAY_READ | MAY_WRITE | MAY_EXEC)) != 0)
>                 status = -EACCES;
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index 9602a886f0f0..9b8fd2247533 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -392,6 +392,8 @@ int nfs_mknod(struct user_namespace *, struct inode *, struct dentry *, umode_t,
>               dev_t);
>  int nfs_rename(struct user_namespace *, struct inode *, struct dentry *,
>                struct inode *, struct dentry *, unsigned int);
> +int nfs_get_access(struct inode *inode, const struct cred *cred,
> +                  struct nfs_access_entry *cache, bool may_block);
>
>  /* file.c */
>  int nfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index 494ebc7cd1c0..ccf70d26c5c4 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -611,6 +611,42 @@ static long nfs4_ioctl_file_statx_set(struct file *dst_file,
>         return ret;
>  }
>
> +static long
> +nfs4_ioctl_file_access_get(struct file *file,
> +                          struct nfs_ioctl_nfs4_access __user *uarg)
> +{
> +       struct inode *inode = file_inode(file);
> +       struct nfs_access_entry cache;
> +       __u64 ac_flags;
> +       const struct cred *old_cred;
> +       struct cred *override_cred;
> +       long ret;
> +
> +       if (!NFS_PROTO(inode)->access)
> +               return -ENOTSUPP;
> +
> +       if (get_user(ac_flags, &uarg->ac_flags))
> +               return -EFAULT;
> +
> +       override_cred = prepare_creds();
> +       if (!override_cred)
> +               return -ENOMEM;
> +
> +       if (!(ac_flags & NFS_AC_FLAG_EACCESS)) {
> +               override_cred->fsuid = override_cred->uid;
> +               override_cred->fsgid = override_cred->gid;
> +       }
> +       old_cred = override_creds(override_cred);
> +
> +       ret = nfs_get_access(inode, override_cred, &cache, true);
> +       if (!ret && unlikely(put_user(cache.mask, &uarg->ac_mask) != 0))
> +               ret = -EFAULT;
> +
> +       revert_creds(old_cred);
> +       put_cred(override_cred);
> +       return ret;
> +}
> +
>  static long nfs4_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>         void __user *argp = (void __user *)arg;
> @@ -623,6 +659,9 @@ static long nfs4_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>         case NFS_IOC_FILE_STATX_SET:
>                 ret = nfs4_ioctl_file_statx_set(file, argp);
>                 break;
> +       case NFS_IOC_FILE_ACCESS_GET:
> +               ret = nfs4_ioctl_file_access_get(file, argp);
> +               break;
>         default:
>                 ret = -ENOIOCTLCMD;
>         }
> diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
> index df87da39bc43..b1e50f14db18 100644
> --- a/include/uapi/linux/nfs.h
> +++ b/include/uapi/linux/nfs.h
> @@ -41,6 +41,8 @@
>  #define NFS_IOC_FILE_STATX_GET _IOR('N', 2, struct nfs_ioctl_nfs4_statx)
>  #define NFS_IOC_FILE_STATX_SET _IOW('N', 3, struct nfs_ioctl_nfs4_statx)
>
> +#define NFS_IOC_FILE_ACCESS_GET        _IOR('N', 4, struct nfs_ioctl_nfs4_access)
> +
>  /* Options for struct nfs_ioctl_nfs4_statx */
>  #define NFS_FA_OPTIONS_SYNC_AS_STAT                    0x0000
>  #define NFS_FA_OPTIONS_FORCE_SYNC                      0x2000 /* See statx */
> @@ -125,6 +127,15 @@ struct nfs_ioctl_nfs4_statx {
>         __u64           fa_padding[4];
>  };
>
> +struct nfs_ioctl_nfs4_access {
> +       /* input */
> +       __u64           ac_flags;               /* operation flags */
> +       /* output */
> +       __u64           ac_mask;                /* NFS raw ACCESS reply mask */
> +};
> +
> +#define NFS_AC_FLAG_EACCESS (1UL << 0)
> +
>  /*
>   * NFS stats. The good thing with these values is that NFSv3 errors are
>   * a superset of NFSv2 errors (with the exception of NFSERR_WFLUSH which
> --
> 2.33.1
>
