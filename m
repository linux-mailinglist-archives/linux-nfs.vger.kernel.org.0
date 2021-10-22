Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E55E437E6D
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Oct 2021 21:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhJVTQq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Oct 2021 15:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhJVTQq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Oct 2021 15:16:46 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494D8C061764
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 12:14:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id u13so188208edy.10
        for <linux-nfs@vger.kernel.org>; Fri, 22 Oct 2021 12:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIVbgEA8tYwguW1gv653WtnlmFUSkUSOcZqeyIOEnIg=;
        b=C4MyvztFV5ccmsZjY1gcruZ/zf3C84imCGnGioqiRtvZjQ0coJ+HoPib7HsHeC1CvY
         7tuyXBIJ5JDGAx5IhW7vAtxNR8lHywGMbQDcsKfUTqjDRBckt9noL6dgv7lUn5joL1Jw
         vDTms5/9ojP1T8xCt3Cbolk0Zp8fHB045NJNgINd7Qx1vrh8CokfeH1XuAyCGYnFKjT7
         9q4OQG4znC2xfg9eVdtHHcTUjFse0sbXUwUmW8XP2H9xJ5o4GXUcEfcjFNRfJgAkolCF
         XVWNx6BMXwHQl+72fiJHNVEojOtx725JNpyoB5KT9APUrCmvvlyqYzphgU7LxM91G9FY
         Vrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIVbgEA8tYwguW1gv653WtnlmFUSkUSOcZqeyIOEnIg=;
        b=RzzGW/ITHWQA+fRUulApY4eMkGP+e6aY7y+Qck4wRojpWgn5MzIYTBprGyMuY1bFkX
         WHCto3GGOBCovNmSX5RY4AFZZDUBEt8+1yeRvKZvPzIH3ZydY1BnFhq6dOOD+XHB5JcC
         cEHIV1BKH5WYngGSDW/6ebtLSwga68HdpAkXKnk5urcclpmCYKr0+5QZsqXEB9woqybu
         mPK/rNaRFYVcOjzGsIMDb0pvauRSygmPF+u6WP10lNMb1WPbQIcqBMzb0ghwAGH15ubC
         rw3KKNgynWXbIN4LNNf3Z/JieMN4LsYYLodX6uQqUp/q6GSaR7qw7yZ08iGv5zmk/fyb
         fhgw==
X-Gm-Message-State: AOAM530ZkChk75OIGU61Vm2n4ROHL3yGR7ige/iJ9cHvi2OsXnbgWqQK
        19B8Ye/FL3KP4TYQz3eJLLxGnlbB3tTgGVEUdPw=
X-Google-Smtp-Source: ABdhPJzDV0E9x+dmfPvmgdxhGJJsSKj/fNLbWPXRwijW2F0DlF/CLbo8op7FMDWBAKUSdk+2PbVKJchnim1BDsZNAYI=
X-Received: by 2002:aa7:db85:: with SMTP id u5mr2411609edt.234.1634930066700;
 Fri, 22 Oct 2021 12:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <163466195619.4493.18063027404688028587.stgit@klimt.1015granger.net>
In-Reply-To: <163466195619.4493.18063027404688028587.stgit@klimt.1015granger.net>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 22 Oct 2021 15:14:15 -0400
Message-ID: <CAN-5tyH93fc_UQxZGALe6Z7tGhGnk1gzhiXMQaN2aonZ_FL5=w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] NFS: Move generic FS show macros to global header
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Olga Kornievskaia <kolga@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 19, 2021 at 12:46 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Refactor: Surface useful show_ macros for use by other trace
> subsystems.

This doesn't apply on top of Trond's origin/testing. Are there some
other dependencies I'm missing?

>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfs/nfs4trace.h        |   67 ++++++---------------
>  fs/nfs/nfstrace.h         |  118 +++++-------------------------------
>  include/trace/events/fs.h |  146 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 180 insertions(+), 151 deletions(-)
>  create mode 100644 include/trace/events/fs.h
>
> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> index 7a2567aa2b86..b2f45c825f37 100644
> --- a/fs/nfs/nfs4trace.h
> +++ b/fs/nfs/nfs4trace.h
> @@ -10,6 +10,8 @@
>
>  #include <linux/tracepoint.h>
>
> +#include <trace/events/fs.h>
> +
>  TRACE_DEFINE_ENUM(EPERM);
>  TRACE_DEFINE_ENUM(ENOENT);
>  TRACE_DEFINE_ENUM(EIO);
> @@ -313,19 +315,6 @@ TRACE_DEFINE_ENUM(NFS4ERR_RESET_TO_PNFS);
>                 { NFS4ERR_RESET_TO_MDS, "RESET_TO_MDS" }, \
>                 { NFS4ERR_RESET_TO_PNFS, "RESET_TO_PNFS" })
>
> -#define show_open_flags(flags) \
> -       __print_flags(flags, "|", \
> -               { O_CREAT, "O_CREAT" }, \
> -               { O_EXCL, "O_EXCL" }, \
> -               { O_TRUNC, "O_TRUNC" }, \
> -               { O_DIRECT, "O_DIRECT" })
> -
> -#define show_fmode_flags(mode) \
> -       __print_flags(mode, "|", \
> -               { ((__force unsigned long)FMODE_READ), "READ" }, \
> -               { ((__force unsigned long)FMODE_WRITE), "WRITE" }, \
> -               { ((__force unsigned long)FMODE_EXEC), "EXEC" })
> -
>  #define show_nfs_fattr_flags(valid) \
>         __print_flags((unsigned long)valid, "|", \
>                 { NFS_ATTR_FATTR_TYPE, "TYPE" }, \
> @@ -793,8 +782,8 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
>
>                 TP_STRUCT__entry(
>                         __field(unsigned long, error)
> -                       __field(unsigned int, flags)
> -                       __field(unsigned int, fmode)
> +                       __field(unsigned long, flags)
> +                       __field(unsigned long, fmode)
>                         __field(dev_t, dev)
>                         __field(u32, fhandle)
>                         __field(u64, fileid)
> @@ -812,7 +801,7 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
>
>                         __entry->error = -error;
>                         __entry->flags = flags;
> -                       __entry->fmode = (__force unsigned int)ctx->mode;
> +                       __entry->fmode = (__force unsigned long)ctx->mode;
>                         __entry->dev = ctx->dentry->d_sb->s_dev;
>                         if (!IS_ERR_OR_NULL(state)) {
>                                 inode = state->inode;
> @@ -842,15 +831,15 @@ DECLARE_EVENT_CLASS(nfs4_open_event,
>                 ),
>
>                 TP_printk(
> -                       "error=%ld (%s) flags=%d (%s) fmode=%s "
> +                       "error=%ld (%s) flags=%lu (%s) fmode=%s "
>                         "fileid=%02x:%02x:%llu fhandle=0x%08x "
>                         "name=%02x:%02x:%llu/%s stateid=%d:0x%08x "
>                         "openstateid=%d:0x%08x",
>                          -__entry->error,
>                          show_nfsv4_errors(__entry->error),
>                          __entry->flags,
> -                        show_open_flags(__entry->flags),
> -                        show_fmode_flags(__entry->fmode),
> +                        show_fs_fcntl_open_flags(__entry->flags),
> +                        show_fs_fmode_flags(__entry->fmode),
>                          MAJOR(__entry->dev), MINOR(__entry->dev),
>                          (unsigned long long)__entry->fileid,
>                          __entry->fhandle,
> @@ -904,7 +893,7 @@ TRACE_EVENT(nfs4_cached_open,
>                 TP_printk(
>                         "fmode=%s fileid=%02x:%02x:%llu "
>                         "fhandle=0x%08x stateid=%d:0x%08x",
> -                       __entry->fmode ?  show_fmode_flags(__entry->fmode) :
> +                       __entry->fmode ?  show_fs_fmode_flags(__entry->fmode) :
>                                           "closed",
>                         MAJOR(__entry->dev), MINOR(__entry->dev),
>                         (unsigned long long)__entry->fileid,
> @@ -952,7 +941,7 @@ TRACE_EVENT(nfs4_close,
>                         "fhandle=0x%08x openstateid=%d:0x%08x",
>                         -__entry->error,
>                         show_nfsv4_errors(__entry->error),
> -                       __entry->fmode ?  show_fmode_flags(__entry->fmode) :
> +                       __entry->fmode ?  show_fs_fmode_flags(__entry->fmode) :
>                                           "closed",
>                         MAJOR(__entry->dev), MINOR(__entry->dev),
>                         (unsigned long long)__entry->fileid,
> @@ -961,24 +950,6 @@ TRACE_EVENT(nfs4_close,
>                 )
>  );
>
> -TRACE_DEFINE_ENUM(F_GETLK);
> -TRACE_DEFINE_ENUM(F_SETLK);
> -TRACE_DEFINE_ENUM(F_SETLKW);
> -TRACE_DEFINE_ENUM(F_RDLCK);
> -TRACE_DEFINE_ENUM(F_WRLCK);
> -TRACE_DEFINE_ENUM(F_UNLCK);
> -
> -#define show_lock_cmd(type) \
> -       __print_symbolic((int)type, \
> -               { F_GETLK, "GETLK" }, \
> -               { F_SETLK, "SETLK" }, \
> -               { F_SETLKW, "SETLKW" })
> -#define show_lock_type(type) \
> -       __print_symbolic((int)type, \
> -               { F_RDLCK, "RDLCK" }, \
> -               { F_WRLCK, "WRLCK" }, \
> -               { F_UNLCK, "UNLCK" })
> -
>  DECLARE_EVENT_CLASS(nfs4_lock_event,
>                 TP_PROTO(
>                         const struct file_lock *request,
> @@ -991,8 +962,8 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
>
>                 TP_STRUCT__entry(
>                         __field(unsigned long, error)
> -                       __field(int, cmd)
> -                       __field(char, type)
> +                       __field(unsigned long, cmd)
> +                       __field(unsigned long, type)
>                         __field(loff_t, start)
>                         __field(loff_t, end)
>                         __field(dev_t, dev)
> @@ -1025,8 +996,8 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
>                         "stateid=%d:0x%08x",
>                         -__entry->error,
>                         show_nfsv4_errors(__entry->error),
> -                       show_lock_cmd(__entry->cmd),
> -                       show_lock_type(__entry->type),
> +                       show_fs_fcntl_cmd(__entry->cmd),
> +                       show_fs_fcntl_lock_type(__entry->type),
>                         (long long)__entry->start,
>                         (long long)__entry->end,
>                         MAJOR(__entry->dev), MINOR(__entry->dev),
> @@ -1061,8 +1032,8 @@ TRACE_EVENT(nfs4_set_lock,
>
>                 TP_STRUCT__entry(
>                         __field(unsigned long, error)
> -                       __field(int, cmd)
> -                       __field(char, type)
> +                       __field(unsigned long, cmd)
> +                       __field(unsigned long, type)
>                         __field(loff_t, start)
>                         __field(loff_t, end)
>                         __field(dev_t, dev)
> @@ -1101,8 +1072,8 @@ TRACE_EVENT(nfs4_set_lock,
>                         "stateid=%d:0x%08x lockstateid=%d:0x%08x",
>                         -__entry->error,
>                         show_nfsv4_errors(__entry->error),
> -                       show_lock_cmd(__entry->cmd),
> -                       show_lock_type(__entry->type),
> +                       show_fs_fcntl_cmd(__entry->cmd),
> +                       show_fs_fcntl_lock_type(__entry->type),
>                         (long long)__entry->start,
>                         (long long)__entry->end,
>                         MAJOR(__entry->dev), MINOR(__entry->dev),
> @@ -1219,7 +1190,7 @@ DECLARE_EVENT_CLASS(nfs4_set_delegation_event,
>
>                 TP_printk(
>                         "fmode=%s fileid=%02x:%02x:%llu fhandle=0x%08x",
> -                       show_fmode_flags(__entry->fmode),
> +                       show_fs_fmode_flags(__entry->fmode),
>                         MAJOR(__entry->dev), MINOR(__entry->dev),
>                         (unsigned long long)__entry->fileid,
>                         __entry->fhandle
> diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
> index 8a224871be74..49d432c00bde 100644
> --- a/fs/nfs/nfstrace.h
> +++ b/fs/nfs/nfstrace.h
> @@ -11,27 +11,7 @@
>  #include <linux/tracepoint.h>
>  #include <linux/iversion.h>
>
> -TRACE_DEFINE_ENUM(DT_UNKNOWN);
> -TRACE_DEFINE_ENUM(DT_FIFO);
> -TRACE_DEFINE_ENUM(DT_CHR);
> -TRACE_DEFINE_ENUM(DT_DIR);
> -TRACE_DEFINE_ENUM(DT_BLK);
> -TRACE_DEFINE_ENUM(DT_REG);
> -TRACE_DEFINE_ENUM(DT_LNK);
> -TRACE_DEFINE_ENUM(DT_SOCK);
> -TRACE_DEFINE_ENUM(DT_WHT);
> -
> -#define nfs_show_file_type(ftype) \
> -       __print_symbolic(ftype, \
> -                       { DT_UNKNOWN, "UNKNOWN" }, \
> -                       { DT_FIFO, "FIFO" }, \
> -                       { DT_CHR, "CHR" }, \
> -                       { DT_DIR, "DIR" }, \
> -                       { DT_BLK, "BLK" }, \
> -                       { DT_REG, "REG" }, \
> -                       { DT_LNK, "LNK" }, \
> -                       { DT_SOCK, "SOCK" }, \
> -                       { DT_WHT, "WHT" })
> +#include <trace/events/fs.h>
>
>  TRACE_DEFINE_ENUM(NFS_INO_INVALID_DATA);
>  TRACE_DEFINE_ENUM(NFS_INO_INVALID_ATIME);
> @@ -168,7 +148,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event_done,
>                         (unsigned long long)__entry->fileid,
>                         __entry->fhandle,
>                         __entry->type,
> -                       nfs_show_file_type(__entry->type),
> +                       show_fs_dirent_type(__entry->type),
>                         (unsigned long long)__entry->version,
>                         (long long)__entry->size,
>                         __entry->cache_validity,
> @@ -259,7 +239,7 @@ TRACE_EVENT(nfs_access_exit,
>                         (unsigned long long)__entry->fileid,
>                         __entry->fhandle,
>                         __entry->type,
> -                       nfs_show_file_type(__entry->type),
> +                       show_fs_dirent_type(__entry->type),
>                         (unsigned long long)__entry->version,
>                         (long long)__entry->size,
>                         __entry->cache_validity,
> @@ -270,34 +250,6 @@ TRACE_EVENT(nfs_access_exit,
>                 )
>  );
>
> -TRACE_DEFINE_ENUM(LOOKUP_FOLLOW);
> -TRACE_DEFINE_ENUM(LOOKUP_DIRECTORY);
> -TRACE_DEFINE_ENUM(LOOKUP_AUTOMOUNT);
> -TRACE_DEFINE_ENUM(LOOKUP_PARENT);
> -TRACE_DEFINE_ENUM(LOOKUP_REVAL);
> -TRACE_DEFINE_ENUM(LOOKUP_RCU);
> -TRACE_DEFINE_ENUM(LOOKUP_OPEN);
> -TRACE_DEFINE_ENUM(LOOKUP_CREATE);
> -TRACE_DEFINE_ENUM(LOOKUP_EXCL);
> -TRACE_DEFINE_ENUM(LOOKUP_RENAME_TARGET);
> -TRACE_DEFINE_ENUM(LOOKUP_EMPTY);
> -TRACE_DEFINE_ENUM(LOOKUP_DOWN);
> -
> -#define show_lookup_flags(flags) \
> -       __print_flags(flags, "|", \
> -                       { LOOKUP_FOLLOW, "FOLLOW" }, \
> -                       { LOOKUP_DIRECTORY, "DIRECTORY" }, \
> -                       { LOOKUP_AUTOMOUNT, "AUTOMOUNT" }, \
> -                       { LOOKUP_PARENT, "PARENT" }, \
> -                       { LOOKUP_REVAL, "REVAL" }, \
> -                       { LOOKUP_RCU, "RCU" }, \
> -                       { LOOKUP_OPEN, "OPEN" }, \
> -                       { LOOKUP_CREATE, "CREATE" }, \
> -                       { LOOKUP_EXCL, "EXCL" }, \
> -                       { LOOKUP_RENAME_TARGET, "RENAME_TARGET" }, \
> -                       { LOOKUP_EMPTY, "EMPTY" }, \
> -                       { LOOKUP_DOWN, "DOWN" })
> -
>  DECLARE_EVENT_CLASS(nfs_lookup_event,
>                 TP_PROTO(
>                         const struct inode *dir,
> @@ -324,7 +276,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event,
>                 TP_printk(
>                         "flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
>                         __entry->flags,
> -                       show_lookup_flags(__entry->flags),
> +                       show_fs_lookup_flags(__entry->flags),
>                         MAJOR(__entry->dev), MINOR(__entry->dev),
>                         (unsigned long long)__entry->dir,
>                         __get_str(name)
> @@ -370,7 +322,7 @@ DECLARE_EVENT_CLASS(nfs_lookup_event_done,
>                         "error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
>                         -__entry->error, nfs_show_status(__entry->error),
>                         __entry->flags,
> -                       show_lookup_flags(__entry->flags),
> +                       show_fs_lookup_flags(__entry->flags),
>                         MAJOR(__entry->dev), MINOR(__entry->dev),
>                         (unsigned long long)__entry->dir,
>                         __get_str(name)
> @@ -392,46 +344,6 @@ DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_exit);
>  DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_enter);
>  DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_revalidate_exit);
>
> -TRACE_DEFINE_ENUM(O_WRONLY);
> -TRACE_DEFINE_ENUM(O_RDWR);
> -TRACE_DEFINE_ENUM(O_CREAT);
> -TRACE_DEFINE_ENUM(O_EXCL);
> -TRACE_DEFINE_ENUM(O_NOCTTY);
> -TRACE_DEFINE_ENUM(O_TRUNC);
> -TRACE_DEFINE_ENUM(O_APPEND);
> -TRACE_DEFINE_ENUM(O_NONBLOCK);
> -TRACE_DEFINE_ENUM(O_DSYNC);
> -TRACE_DEFINE_ENUM(O_DIRECT);
> -TRACE_DEFINE_ENUM(O_LARGEFILE);
> -TRACE_DEFINE_ENUM(O_DIRECTORY);
> -TRACE_DEFINE_ENUM(O_NOFOLLOW);
> -TRACE_DEFINE_ENUM(O_NOATIME);
> -TRACE_DEFINE_ENUM(O_CLOEXEC);
> -
> -#define show_open_flags(flags) \
> -       __print_flags(flags, "|", \
> -               { O_WRONLY, "O_WRONLY" }, \
> -               { O_RDWR, "O_RDWR" }, \
> -               { O_CREAT, "O_CREAT" }, \
> -               { O_EXCL, "O_EXCL" }, \
> -               { O_NOCTTY, "O_NOCTTY" }, \
> -               { O_TRUNC, "O_TRUNC" }, \
> -               { O_APPEND, "O_APPEND" }, \
> -               { O_NONBLOCK, "O_NONBLOCK" }, \
> -               { O_DSYNC, "O_DSYNC" }, \
> -               { O_DIRECT, "O_DIRECT" }, \
> -               { O_LARGEFILE, "O_LARGEFILE" }, \
> -               { O_DIRECTORY, "O_DIRECTORY" }, \
> -               { O_NOFOLLOW, "O_NOFOLLOW" }, \
> -               { O_NOATIME, "O_NOATIME" }, \
> -               { O_CLOEXEC, "O_CLOEXEC" })
> -
> -#define show_fmode_flags(mode) \
> -       __print_flags(mode, "|", \
> -               { ((__force unsigned long)FMODE_READ), "READ" }, \
> -               { ((__force unsigned long)FMODE_WRITE), "WRITE" }, \
> -               { ((__force unsigned long)FMODE_EXEC), "EXEC" })
> -
>  TRACE_EVENT(nfs_atomic_open_enter,
>                 TP_PROTO(
>                         const struct inode *dir,
> @@ -443,7 +355,7 @@ TRACE_EVENT(nfs_atomic_open_enter,
>
>                 TP_STRUCT__entry(
>                         __field(unsigned long, flags)
> -                       __field(unsigned int, fmode)
> +                       __field(unsigned long, fmode)
>                         __field(dev_t, dev)
>                         __field(u64, dir)
>                         __string(name, ctx->dentry->d_name.name)
> @@ -453,15 +365,15 @@ TRACE_EVENT(nfs_atomic_open_enter,
>                         __entry->dev = dir->i_sb->s_dev;
>                         __entry->dir = NFS_FILEID(dir);
>                         __entry->flags = flags;
> -                       __entry->fmode = (__force unsigned int)ctx->mode;
> +                       __entry->fmode = (__force unsigned long)ctx->mode;
>                         __assign_str(name, ctx->dentry->d_name.name);
>                 ),
>
>                 TP_printk(
>                         "flags=0x%lx (%s) fmode=%s name=%02x:%02x:%llu/%s",
>                         __entry->flags,
> -                       show_open_flags(__entry->flags),
> -                       show_fmode_flags(__entry->fmode),
> +                       show_fs_fcntl_open_flags(__entry->flags),
> +                       show_fs_fmode_flags(__entry->fmode),
>                         MAJOR(__entry->dev), MINOR(__entry->dev),
>                         (unsigned long long)__entry->dir,
>                         __get_str(name)
> @@ -481,7 +393,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
>                 TP_STRUCT__entry(
>                         __field(unsigned long, error)
>                         __field(unsigned long, flags)
> -                       __field(unsigned int, fmode)
> +                       __field(unsigned long, fmode)
>                         __field(dev_t, dev)
>                         __field(u64, dir)
>                         __string(name, ctx->dentry->d_name.name)
> @@ -492,7 +404,7 @@ TRACE_EVENT(nfs_atomic_open_exit,
>                         __entry->dev = dir->i_sb->s_dev;
>                         __entry->dir = NFS_FILEID(dir);
>                         __entry->flags = flags;
> -                       __entry->fmode = (__force unsigned int)ctx->mode;
> +                       __entry->fmode = (__force unsigned long)ctx->mode;
>                         __assign_str(name, ctx->dentry->d_name.name);
>                 ),
>
> @@ -501,8 +413,8 @@ TRACE_EVENT(nfs_atomic_open_exit,
>                         "name=%02x:%02x:%llu/%s",
>                         -__entry->error, nfs_show_status(__entry->error),
>                         __entry->flags,
> -                       show_open_flags(__entry->flags),
> -                       show_fmode_flags(__entry->fmode),
> +                       show_fs_fcntl_open_flags(__entry->flags),
> +                       show_fs_fmode_flags(__entry->fmode),
>                         MAJOR(__entry->dev), MINOR(__entry->dev),
>                         (unsigned long long)__entry->dir,
>                         __get_str(name)
> @@ -535,7 +447,7 @@ TRACE_EVENT(nfs_create_enter,
>                 TP_printk(
>                         "flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
>                         __entry->flags,
> -                       show_open_flags(__entry->flags),
> +                       show_fs_fcntl_open_flags(__entry->flags),
>                         MAJOR(__entry->dev), MINOR(__entry->dev),
>                         (unsigned long long)__entry->dir,
>                         __get_str(name)
> @@ -572,7 +484,7 @@ TRACE_EVENT(nfs_create_exit,
>                         "error=%ld (%s) flags=0x%lx (%s) name=%02x:%02x:%llu/%s",
>                         -__entry->error, nfs_show_status(__entry->error),
>                         __entry->flags,
> -                       show_open_flags(__entry->flags),
> +                       show_fs_fcntl_open_flags(__entry->flags),
>                         MAJOR(__entry->dev), MINOR(__entry->dev),
>                         (unsigned long long)__entry->dir,
>                         __get_str(name)
> diff --git a/include/trace/events/fs.h b/include/trace/events/fs.h
> new file mode 100644
> index 000000000000..84e20c43d0c3
> --- /dev/null
> +++ b/include/trace/events/fs.h
> @@ -0,0 +1,146 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Display helpers for generic filesystem items
> + *
> + * Author: Chuck Lever <chuck.lever@oracle.com>
> + *
> + * Copyright (c) 2020, Oracle and/or its affiliates.
> + */
> +
> +#include <linux/fs.h>
> +
> +#define show_fs_dirent_type(x) \
> +       __print_symbolic(x, \
> +               { DT_UNKNOWN,           "UNKNOWN" }, \
> +               { DT_FIFO,              "FIFO" }, \
> +               { DT_CHR,               "CHR" }, \
> +               { DT_DIR,               "DIR" }, \
> +               { DT_BLK,               "BLK" }, \
> +               { DT_REG,               "REG" }, \
> +               { DT_LNK,               "LNK" }, \
> +               { DT_SOCK,              "SOCK" }, \
> +               { DT_WHT,               "WHT" })
> +
> +#define show_fs_fcntl_open_flags(x) \
> +       __print_flags(x, "|", \
> +               { O_WRONLY,             "O_WRONLY" }, \
> +               { O_RDWR,               "O_RDWR" }, \
> +               { O_CREAT,              "O_CREAT" }, \
> +               { O_EXCL,               "O_EXCL" }, \
> +               { O_NOCTTY,             "O_NOCTTY" }, \
> +               { O_TRUNC,              "O_TRUNC" }, \
> +               { O_APPEND,             "O_APPEND" }, \
> +               { O_NONBLOCK,           "O_NONBLOCK" }, \
> +               { O_DSYNC,              "O_DSYNC" }, \
> +               { O_DIRECT,             "O_DIRECT" }, \
> +               { O_LARGEFILE,          "O_LARGEFILE" }, \
> +               { O_DIRECTORY,          "O_DIRECTORY" }, \
> +               { O_NOFOLLOW,           "O_NOFOLLOW" }, \
> +               { O_NOATIME,            "O_NOATIME" }, \
> +               { O_CLOEXEC,            "O_CLOEXEC" })
> +
> +#define __fmode_flag(x)        { (__force unsigned long)FMODE_##x, #x }
> +#define show_fs_fmode_flags(x) \
> +       __print_flags(x, "|", \
> +               __fmode_flag(READ), \
> +               __fmode_flag(WRITE), \
> +               __fmode_flag(LSEEK), \
> +               __fmode_flag(PREAD), \
> +               __fmode_flag(PWRITE), \
> +               __fmode_flag(EXEC), \
> +               __fmode_flag(NDELAY), \
> +               __fmode_flag(EXCL), \
> +               __fmode_flag(WRITE_IOCTL), \
> +               __fmode_flag(32BITHASH), \
> +               __fmode_flag(64BITHASH), \
> +               __fmode_flag(NOCMTIME), \
> +               __fmode_flag(RANDOM), \
> +               __fmode_flag(UNSIGNED_OFFSET), \
> +               __fmode_flag(PATH), \
> +               __fmode_flag(ATOMIC_POS), \
> +               __fmode_flag(WRITER), \
> +               __fmode_flag(CAN_READ), \
> +               __fmode_flag(CAN_WRITE), \
> +               __fmode_flag(OPENED), \
> +               __fmode_flag(CREATED), \
> +               __fmode_flag(STREAM), \
> +               __fmode_flag(NONOTIFY), \
> +               __fmode_flag(NOWAIT), \
> +               __fmode_flag(NEED_UNMOUNT), \
> +               __fmode_flag(NOACCOUNT), \
> +               __fmode_flag(BUF_RASYNC))
> +
> +#ifdef CONFIG_64BIT
> +#define show_fs_fcntl_cmd(x) \
> +       __print_symbolic(x, \
> +               { F_DUPFD,              "DUPFD" }, \
> +               { F_GETFD,              "GETFD" }, \
> +               { F_SETFD,              "SETFD" }, \
> +               { F_GETFL,              "GETFL" }, \
> +               { F_SETFL,              "SETFL" }, \
> +               { F_GETLK,              "GETLK" }, \
> +               { F_SETLK,              "SETLK" }, \
> +               { F_SETLKW,             "SETLKW" }, \
> +               { F_SETOWN,             "SETOWN" }, \
> +               { F_GETOWN,             "GETOWN" }, \
> +               { F_SETSIG,             "SETSIG" }, \
> +               { F_GETSIG,             "GETSIG" }, \
> +               { F_SETOWN_EX,          "SETOWN_EX" }, \
> +               { F_GETOWN_EX,          "GETOWN_EX" }, \
> +               { F_GETOWNER_UIDS,      "GETOWNER_UIDS" }, \
> +               { F_OFD_GETLK,          "OFD_GETLK" }, \
> +               { F_OFD_SETLK,          "OFD_SETLK" }, \
> +               { F_OFD_SETLKW,         "OFD_SETLKW" })
> +#else /* CONFIG_64BIT */
> +#define show_fs_fcntl_cmd(x) \
> +       __print_symbolic(x, \
> +               { F_DUPFD,              "DUPFD" }, \
> +               { F_GETFD,              "GETFD" }, \
> +               { F_SETFD,              "SETFD" }, \
> +               { F_GETFL,              "GETFL" }, \
> +               { F_SETFL,              "SETFL" }, \
> +               { F_GETLK,              "GETLK" }, \
> +               { F_SETLK,              "SETLK" }, \
> +               { F_SETLKW,             "SETLKW" }, \
> +               { F_SETOWN,             "SETOWN" }, \
> +               { F_GETOWN,             "GETOWN" }, \
> +               { F_SETSIG,             "SETSIG" }, \
> +               { F_GETSIG,             "GETSIG" }, \
> +               { F_GETLK64,            "GETLK64" }, \
> +               { F_SETLK64,            "SETLK64" }, \
> +               { F_SETLKW64,           "SETLKW64" }, \
> +               { F_SETOWN_EX,          "SETOWN_EX" }, \
> +               { F_GETOWN_EX,          "GETOWN_EX" }, \
> +               { F_GETOWNER_UIDS,      "GETOWNER_UIDS" }, \
> +               { F_OFD_GETLK,          "OFD_GETLK" }, \
> +               { F_OFD_SETLK,          "OFD_SETLK" }, \
> +               { F_OFD_SETLKW,         "OFD_SETLKW" })
> +#endif /* CONFIG_64BIT */
> +
> +#define show_fs_fcntl_lock_type(x) \
> +       __print_symbolic(x, \
> +               { F_RDLCK,              "RDLCK" }, \
> +               { F_WRLCK,              "WRLCK" }, \
> +               { F_UNLCK,              "UNLCK" })
> +
> +#define show_fs_lookup_flags(flags) \
> +       __print_flags(flags, "|", \
> +               { LOOKUP_FOLLOW,        "FOLLOW" }, \
> +               { LOOKUP_DIRECTORY,     "DIRECTORY" }, \
> +               { LOOKUP_AUTOMOUNT,     "AUTOMOUNT" }, \
> +               { LOOKUP_EMPTY,         "EMPTY" }, \
> +               { LOOKUP_DOWN,          "DOWN" }, \
> +               { LOOKUP_MOUNTPOINT,    "MOUNTPOINT" }, \
> +               { LOOKUP_REVAL,         "REVAL" }, \
> +               { LOOKUP_RCU,           "RCU" }, \
> +               { LOOKUP_OPEN,          "OPEN" }, \
> +               { LOOKUP_CREATE,        "CREATE" }, \
> +               { LOOKUP_EXCL,          "EXCL" }, \
> +               { LOOKUP_RENAME_TARGET, "RENAME_TARGET" }, \
> +               { LOOKUP_PARENT,        "PARENT" }, \
> +               { LOOKUP_NO_SYMLINKS,   "NO_SYMLINKS" }, \
> +               { LOOKUP_NO_MAGICLINKS, "NO_MAGICLINKS" }, \
> +               { LOOKUP_NO_XDEV,       "NO_XDEV" }, \
> +               { LOOKUP_BENEATH,       "BENEATH" }, \
> +               { LOOKUP_IN_ROOT,       "IN_ROOT" }, \
> +               { LOOKUP_CACHED,        "CACHED" })
>
