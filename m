Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC823D2D14
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jul 2021 22:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhGVTWO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Jul 2021 15:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhGVTWN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Jul 2021 15:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626984167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7rdoIzLCisnr7eFt+OK0D5B3QFvR/rOqUZ4eP6P3mg4=;
        b=LXPy45HdwIzkXB115Lx2ul3/MIJxK7GAvZUesZds0Wch9bKyfXk9nLkFe/WqDjZ3RxxUqq
        5HYkV7sEjLQJ1DtIrhB7NpgZVDiAKUu5sfSTxm2HdoKEhZMd5+AtM77iwla8z26Y+/kTDj
        oi/O0mQ8K9fiqsUfgZcqGMwIGEU+/CI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-k7AnssEjOKOJ8YMi6DaHpw-1; Thu, 22 Jul 2021 16:02:46 -0400
X-MC-Unique: k7AnssEjOKOJ8YMi6DaHpw-1
Received: by mail-ej1-f72.google.com with SMTP id p26-20020a17090653dab0290549bc29d4d7so26572ejo.20
        for <linux-nfs@vger.kernel.org>; Thu, 22 Jul 2021 13:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rdoIzLCisnr7eFt+OK0D5B3QFvR/rOqUZ4eP6P3mg4=;
        b=Ha9mzOoRJvn/le5u3S8RTZQMKwPfpBQbPfossscdQFFziVNVrHehq0jpyrbPpWUia6
         o9r2R8UUUiFtp5y+zPIFH0PpsxwB9rUmuxWXd1fmbd9P70TphyNSR6TsOec3v8nitTyN
         OlAlbGEoDe9BFb7kjJjajovKx8/+yeqS4OKwiKzxsGwUu8iewnFwgzXKW7GG8BuYlP4s
         2y9f+Y9maOKdf3htsk9xL7DUFSwmR8PARNm6MvhV98G2rxRAZ5tKRnVManyr1FYr1jZT
         1OkB3wpMVu3i/iNC3vjFs2ssY+G3JZhOFsP9LIDTOPvRSPWJ4dnq4ILDQxdNwOw5L6aa
         zeIA==
X-Gm-Message-State: AOAM533WjlCpQF6NA9l05F1T5kfP5wvDtLK3ERqO4K5FFBzEKXkGwINy
        26GSJsXgUe/WkUt7SpI1rKOao0tCMtPRdOoKsEAEuCmKwZ/CW0ULdJSDNJfVbaHcCm5HPmtweZ1
        niqXW8lFGqYIw7qt1wE2alVJDzrjG4JF1cwKO
X-Received: by 2002:a17:906:f84a:: with SMTP id ks10mr1341626ejb.537.1626984165171;
        Thu, 22 Jul 2021 13:02:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN/Ovr3i5JbOwMPwkAzdDdAM+rWaIJJ5sk9f05RAFN7L6HvB1DicTtAuQuVa7h5f9fUlFlHEiv2fF47LBi8X8=
X-Received: by 2002:a17:906:f84a:: with SMTP id ks10mr1341611ejb.537.1626984164935;
 Thu, 22 Jul 2021 13:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210720212611.332856-1-steved@redhat.com>
In-Reply-To: <20210720212611.332856-1-steved@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 22 Jul 2021 16:02:09 -0400
Message-ID: <CALF+zOkEtL9DuO68oM=j_8Dt-0Gvx7KxG7jb-KHLsnNgf3-0mg@mail.gmail.com>
Subject: Re: [PATCH] mount.nfs: Fix the sloppy option processing
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 20, 2021 at 5:27 PM Steve Dickson <steved@redhat.com> wrote:
>
> The new mount API broke how the sloppy option is parsed.
> So the option processing needs to be moved up in
> the mount.nfs command.
>
> The option needs to be the first option in the string
> that is passed into the kernel with the -s mount(8)
> and/or the -o sloppy is used.
>
> Commit 92b664ef fixed the process of the -s flag
> and this version fixes the -o sloppy processing
> as well works when libmount-mount is and is not
> enabled plus cleans up the mount options passed
> to the kernel.
>
> Signed-off-by: Steve Dickson <steved@redhat.com>
> ---
>  utils/mount/nfs.man   |  7 +++++++
>  utils/mount/stropts.c | 14 +++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
> index f98cb47d..f1b76936 100644
> --- a/utils/mount/nfs.man
> +++ b/utils/mount/nfs.man
> @@ -555,6 +555,13 @@ using the FS-Cache facility. See cachefilesd(8)
>  and <kernel_source>/Documentation/filesystems/caching
>  for detail on how to configure the FS-Cache facility.
>  Default value is nofsc.
> +.TP 1.5i
> +.B sloppy
> +The
> +.B sloppy
> +option is an alternative to specifying
> +.BR mount.nfs " -s " option.
> +
>  .SS "Options for NFS versions 2 and 3 only"
>  Use these options, along with the options in the above subsection,
>  for NFS versions 2 and 3 only.
> diff --git a/utils/mount/stropts.c b/utils/mount/stropts.c
> index 82b054a5..fa67a66f 100644
> --- a/utils/mount/stropts.c
> +++ b/utils/mount/stropts.c
> @@ -339,11 +339,19 @@ static int nfs_verify_lock_option(struct mount_options *options)
>
>  static int nfs_insert_sloppy_option(struct mount_options *options)
>  {
> -       if (!sloppy || linux_version_code() < MAKE_VERSION(2, 6, 27))
> +       if (linux_version_code() < MAKE_VERSION(2, 6, 27))
>                 return 1;
>
> -       if (po_insert(options, "sloppy") == PO_FAILED)
> -               return 0;
> +       if (po_contains(options, "sloppy")) {
> +               po_remove_all(options, "sloppy");
> +               sloppy++;
> +       }
> +
> +       if (sloppy) {
> +               if (po_insert(options, "sloppy") == PO_FAILED)
> +                       return 0;
> +       }
> +
>         return 1;
>  }
>
> --
> 2.31.1
>

Looks good.

Tested with 1-liner, failed before this patch.

# FAIL=0; for o in blah,vers=4.1,sec=sys,sloppy
blah,vers=4.1,sloppy,sec=sys sloppy,blah,vers=4.1,sec=sys
vers=4.1,blah,sec=sys,sloppy vers=4.1,blah,sloppy,sec=sys
vers=4.1,sloppy,blah,sec=sys sloppy,vers=4.1,blah,sec=sys
sloppy,vers=4.1,sec=sys,blah; do ./utils/mount/mount.nfs -o $o
127.0.0.1:/exports /mnt/test; if [ $? -ne 0 ]; then FAIL=1; echo
ERROR: on options $o; break; fi; umount /mnt/test; done; if [ $FAIL
-eq 0 ]; then echo SUCCESS on kernel $(uname -r) nfs-utils at $(git
log --oneline | head -1); fi
mount.nfs: an incorrect mount option was specified
ERROR: on options blah,vers=4.1,sec=sys,sloppy

# FAIL=0; for o in blah,vers=4.1,sec=sys,sloppy
blah,vers=4.1,sloppy,sec=sys sloppy,blah,vers=4.1,sec=sys
vers=4.1,blah,sec=sys,sloppy vers=4.1,blah,sloppy,sec=sys
vers=4.1,sloppy,blah,sec=sys sloppy,vers=4.1,blah,sec=sys
sloppy,vers=4.1,sec=sys,blah; do ./utils/mount/mount.nfs -o $o
127.0.0.1:/exports /mnt/test; if [ $? -ne 0 ]; then FAIL=1; echo
ERROR: on options $o; break; fi; umount /mnt/test; done; if [ $FAIL
-eq 0 ]; then echo SUCCESS on kernel $(uname -r) nfs-utils at $(git
log --oneline | head -1); fi
SUCCESS on kernel 5.14.0-rc2 nfs-utils at d3e53193c6d6 mount.nfs: Fix
the sloppy option processing


Reviewed-and-tested-by: Dave Wysochanski <dwysocha@redhat.com>

