Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B645872B8
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 23:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiHAVEb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Aug 2022 17:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiHAVEb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Aug 2022 17:04:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D14237FAA
        for <linux-nfs@vger.kernel.org>; Mon,  1 Aug 2022 14:04:29 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m22so7369382lfl.9
        for <linux-nfs@vger.kernel.org>; Mon, 01 Aug 2022 14:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+lZWiOrmOQMd/ReRZ/qKqoYsgyLtc/MVdP1DCehLKtc=;
        b=HfKcDPL4NyGH5KVduIxFCh2hWMtAjpiqsqbXk7MGFsqTV71dPI/EcvYcuenMfOsYgm
         clQveOoKfJ/0Pgc2Mvx35FNX8llCquLZ7ZFoeD5F50QmLKpNrETpdL2wkRlC8AU1DVNB
         bGxrocGpkfg8URudEyykynWo7J8Cn8TI/+KBMvmUvpq2cZc7cuRKwlsuEAxlhd/HSRHX
         K9XrgNp4OZNQtB1AhDUUxZ7UuaD/maRzrFKLB4k93YQGH+KSKoMZAy26WN2dSAhQT7lx
         9CdFl+JSMV8ZCrTaov0SelUtbthigBllH6K2t6TxwShVYxFTXUAv2mOlca79AG7fPBtc
         T4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+lZWiOrmOQMd/ReRZ/qKqoYsgyLtc/MVdP1DCehLKtc=;
        b=fyIkDUnm4emrjm/MUVc1GPyIqTEJvDtikkhxH1lEEWV+JnCGIYKZiSbtWPs//4seiP
         zeMIwQXEBlo0dwqcrsCuAmSRGZw/Ki6FcrGmLBCsFTnDZ4Gr6kvZaURxGDkQZzCVgiJ1
         v1iVTjQYxotCfPMRXxLD5tDxrjrUBCYv3SlGWSNipzrBVeo2bJmL/A7oJKQK8+7OtYXG
         fpMufvXt4mImfLRPdPwx/kpfHE5bBXLHF9qj/JEUD/E8pOTnUmhFI8P8MgzI4B44K4NA
         ISuavjIgHFNysLOYtJMCOjXXWegQJad4b+s8TYO8RfZp9e0My8KpeZApADJ578h6Wnf5
         Q9sg==
X-Gm-Message-State: AJIora8fBy8rRjilnp+R2Qt8/MGyS7zw3FsEAHhaIYFgAsEEF06swwje
        9uwBALM1dlpE4lEfUBGjn750uJpJzNv95Xcuyq0=
X-Google-Smtp-Source: AGRyM1thT90TXgOt36d15BkUgE7/U73+jIqmkDdsNprI+9Bau9zMhy0qZhgF/EoDHqrcDXDHx8ZuOHNvkVUkwY/bGvk=
X-Received: by 2002:ac2:57d3:0:b0:48a:cb98:b32e with SMTP id
 k19-20020ac257d3000000b0048acb98b32emr6340843lfo.512.1659387867801; Mon, 01
 Aug 2022 14:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220801195726.154229-1-jlayton@kernel.org>
In-Reply-To: <20220801195726.154229-1-jlayton@kernel.org>
From:   Jan Kasiak <j.kasiak@gmail.com>
Date:   Mon, 1 Aug 2022 17:04:16 -0400
Message-ID: <CAD15GZdz8+oUqJmDxit_NCSJqnD-3J40WkmyVJLQXp+r1yHrWA@mail.gmail.com>
Subject: Re: [PATCH v2] lockd: detect and reject lock arguments that overflow
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>, bfields@fieldses.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff,

Can't speak to everything, but applying this patch on my system fixes
the issues I was having.

Thanks for the quick patch!

Jan

On Mon, Aug 1, 2022 at 3:57 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> lockd doesn't currently vet the start and length in nlm4 requests like
> it should, and can end up generating lock requests with arguments that
> overflow when passed to the filesystem.
>
> The NLM4 protocol uses unsigned 64-bit arguments for both start and
> length, whereas struct file_lock tracks the start and end as loff_t
> values. By the time we get around to calling nlm4svc_retrieve_args,
> we've lost the information that would allow us to determine if there was
> an overflow.
>
> Start tracking the actual start and len for NLM4 requests in the
> nlm_lock. In nlm4svc_retrieve_args, vet these values to ensure they
> won't cause an overflow, and return NLM4_FBIG if they do.
>
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=392
> Reported-by: Jan Kasiak <j.kasiak@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/lockd/svc4proc.c       |  8 ++++++++
>  fs/lockd/xdr4.c           | 19 ++-----------------
>  include/linux/lockd/xdr.h |  2 ++
>  3 files changed, 12 insertions(+), 17 deletions(-)
>
> v2: record args as u64s in nlm_lock and check them in
>     nlm4svc_retrieve_args
>
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 176b468a61c7..e5adb524a445 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -32,6 +32,10 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
>         if (!nlmsvc_ops)
>                 return nlm_lck_denied_nolocks;
>
> +       if (lock->lock_start > OFFSET_MAX ||
> +           (lock->lock_len && ((lock->lock_len - 1) > (OFFSET_MAX - lock->lock_start))))
> +               return nlm4_fbig;
> +
>         /* Obtain host handle */
>         if (!(host = nlmsvc_lookup_host(rqstp, lock->caller, lock->len))
>          || (argp->monitor && nsm_monitor(host) < 0))
> @@ -50,6 +54,10 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
>                 /* Set up the missing parts of the file_lock structure */
>                 lock->fl.fl_file  = file->f_file[mode];
>                 lock->fl.fl_pid = current->tgid;
> +               lock->fl.fl_start = (loff_t)lock->lock_start;
> +               lock->fl.fl_end = lock->lock_len ?
> +                                  (loff_t)(lock->lock_start + lock->lock_len - 1) :
> +                                  OFFSET_MAX;
>                 lock->fl.fl_lmops = &nlmsvc_lock_operations;
>                 nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
>                 if (!lock->fl.fl_owner) {
> diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
> index 856267c0864b..712fdfeb8ef0 100644
> --- a/fs/lockd/xdr4.c
> +++ b/fs/lockd/xdr4.c
> @@ -20,13 +20,6 @@
>
>  #include "svcxdr.h"
>
> -static inline loff_t
> -s64_to_loff_t(__s64 offset)
> -{
> -       return (loff_t)offset;
> -}
> -
> -
>  static inline s64
>  loff_t_to_s64(loff_t offset)
>  {
> @@ -70,8 +63,6 @@ static bool
>  svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
>  {
>         struct file_lock *fl = &lock->fl;
> -       u64 len, start;
> -       s64 end;
>
>         if (!svcxdr_decode_string(xdr, &lock->caller, &lock->len))
>                 return false;
> @@ -81,20 +72,14 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
>                 return false;
>         if (xdr_stream_decode_u32(xdr, &lock->svid) < 0)
>                 return false;
> -       if (xdr_stream_decode_u64(xdr, &start) < 0)
> +       if (xdr_stream_decode_u64(xdr, &lock->lock_start) < 0)
>                 return false;
> -       if (xdr_stream_decode_u64(xdr, &len) < 0)
> +       if (xdr_stream_decode_u64(xdr, &lock->lock_len) < 0)
>                 return false;
>
>         locks_init_lock(fl);
>         fl->fl_flags = FL_POSIX;
>         fl->fl_type  = F_RDLCK;
> -       end = start + len - 1;
> -       fl->fl_start = s64_to_loff_t(start);
> -       if (len == 0 || end < 0)
> -               fl->fl_end = OFFSET_MAX;
> -       else
> -               fl->fl_end = s64_to_loff_t(end);
>
>         return true;
>  }
> diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
> index 398f70093cd3..67e4a2c5500b 100644
> --- a/include/linux/lockd/xdr.h
> +++ b/include/linux/lockd/xdr.h
> @@ -41,6 +41,8 @@ struct nlm_lock {
>         struct nfs_fh           fh;
>         struct xdr_netobj       oh;
>         u32                     svid;
> +       u64                     lock_start;
> +       u64                     lock_len;
>         struct file_lock        fl;
>  };
>
> --
> 2.37.1
>
