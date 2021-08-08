Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB743E3D26
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 01:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhHHXXg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Aug 2021 19:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhHHXXg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Aug 2021 19:23:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02956C061760
        for <linux-nfs@vger.kernel.org>; Sun,  8 Aug 2021 16:23:16 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso3887620pjb.2
        for <linux-nfs@vger.kernel.org>; Sun, 08 Aug 2021 16:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daw+16DHDq0G8H4y6A4R5DAomFfpR/+W1JzeaqA7ZX8=;
        b=m1VHCGQ5eoXY7c/K9sBdGP3aavm1a9AEIpJa33EjlLThdZm4lDiptN274NPQxnm63O
         8/dozun46OM+9xQyHlD3AilU1TwWCST/AOusG6iwQ3Tt34A1v6LosKxVjIte4B27I0D0
         Lket/oLfaefgqJXgpGu6hGbxWYuPsl+PvYKPwAgYXIyHcxtAYL4lx0XnA5+iq68J68zY
         QLl1cT/DVpht6EMzh+Zarc+RAruXZ62dm3Nyap3G0Kd4NmGkxHzqALO8i9kpHYkE8baY
         yLqqaeL3jpl6xv2FVB+6uBPz6URDozmxHX3YCHIw2nb1ocybe+mPGyF5O39laznJq5uN
         iE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daw+16DHDq0G8H4y6A4R5DAomFfpR/+W1JzeaqA7ZX8=;
        b=St6ZynwF+0ho2adg59vFH3OPNVhCjzFl41eqv+XVxhSnrAYzwTCW24FZEx4jIcFWjK
         HjNcUa2wHgpf8z5lCwi34UrR9Ggt4QilakYvEbD8WaH8BZB40qfnZGRM2/J28t/AF1Or
         CFCeiPnwBTYKhl/fVXxTpji5BwxKMAaXL1kjB81Jiqs1rQerMdfP9avNYYbsJpYrZhPi
         nIWvdvZpaCPYuiuh1jQte8R3UBk0Sgdw0FaZFmZb05tBgfuiq1c7swwKldo8r797YIMA
         q1i5UD/n/c3qOUb0Q22z5Vft4v3Pb1qWMPl2fzL7U2aybuEfR4OWqlVGnZM8q2CHY+h0
         TW+A==
X-Gm-Message-State: AOAM5322qZwF4hZ44OhUaCfiWBe/COHt0X/myVo4fkwKVB91xj5QwsvU
        VcUgGJmIN3uSHKv1q0Ju9NGgri1ETsVjyxp/QG0=
X-Google-Smtp-Source: ABdhPJzYC669zW8lqAbi9Qgedhqq481H1KOLT6rro15IXxolfFlUhodiy24FYVPpaa5AalpnA7u8sPMabZ+ncDwjOcI=
X-Received: by 2002:a17:903:181:b029:12c:e578:5a4e with SMTP id
 z1-20020a1709030181b029012ce5785a4emr3037523plg.12.1628464996365; Sun, 08 Aug
 2021 16:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <3349D119-2F35-4A58-8061-A2659E8C6BB9@oracle.com>
In-Reply-To: <3349D119-2F35-4A58-8061-A2659E8C6BB9@oracle.com>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Sun, 8 Aug 2021 16:23:05 -0700
Message-ID: <CAOv1SKAGuGYDr-qtdSJ0wkVkfqp5i27ZTZ8hhb9-byp4MsfVGQ@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I appreciate that Chuck. It was not my intention to seek basic "user"
support, but as I don't know the intricacies of how nfs works in the
kernel, I don't know where to get the right information to share to
help with the diagnostic effort. I have read through the
troubleshooting recommendations on the linux-nfs wiki, but the issue
is beyond what is indicated there, and my setup has been running
without any NFS issues for years at this point, and I can demonstrate
the error merely by changing the booted kernel, so I feel confident
it's not a simple configuration error.

I have raised an issue on the ArchLinux bug tracker as well
(https://bugs.archlinux.org/task/71775). Given that the ArchLinux
version of the kernel has minimal delta from mainline, (I've checked
and no fs/rpc/nfs files are changed in 7 file delta vs mainline), it's
been my previous experience that they will refer me to the kernel
subsystem mailing list, but I will wait to hear back from them, and
see what they say.

- mike


- mike









On Sun, Aug 8, 2021 at 3:47 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Aug 8, 2021, at 6:37 PM, Mike Javorski <mike.javorski@gmail.com> wrote:
> >
> > I have been experiencing nfs file access hangs with multiple release
> > versions of the 5.13.x linux kernel. In each case, all file transfers
> > freeze for 5-10 seconds and then resume. This seems worse when reading
> > through many files sequentially.
> >
> > My server:
> > - Archlinux w/ a distribution provided kernel package
> > - filesystems exported with "rw,sync,no_subtree_check,insecure" options
> >
> > Client:
> > - Archlinux w/ latest distribution provided kernel (5.13.9-arch1-1 at writing)
> > - nfs mounted via /net autofs with "soft,nodev,nosuid" options
> > (ver=4.2 is indicated in mount)
> >
> > I have tried the 5.13.x kernel several times since the first arch
> > release (most recently with 5.13.9-arch1-1), all with similar results.
> > Each time, I am forced to downgrade the linux package to a 5.12.x
> > kernel (5.12.15-arch1 as of writing) to clear up the transfer issues
> > and stabilize performance. No other changes are made between tests. I
> > have confirmed the freezing behavior using both ext4 and btrfs
> > filesystems exported from this server.
> >
> > At this point I would appreciate some guidance in what to provide in
> > order to diagnose and resolve this issue. I don't have a lot of kernel
> > debugging experience, so instruction would be helpful.
>
> Hi Mike-
>
> Thanks for the report.
>
> Since you are using a distribution kernel and don't have much
> kernel debugging experience, we typically ask you to work with
> your distributor first. linux-nfs@ is a developer's mailing
> list, we're not really prepared to provide user support.
>
> When you report the problem to Arch, you might want to have
> a description of your workload (especially if you can
> reproduce the problem often with a particular application
> or user activity), and maybe be prepared to capture a network
> trace of the failure using tcpdump.
>
>
> --
> Chuck Lever
>
>
>
